// frontend/editor.js
import { EditorView, basicSetup } from "codemirror";
import { ChangeSet, StateEffect, StateField } from "@codemirror/state";
import { Decoration, ViewPlugin, WidgetType } from "@codemirror/view";
import { StreamLanguage } from "@codemirror/language";
import { ruby } from "@codemirror/legacy-modes/mode/ruby";
import { oneDark } from "@codemirror/theme-one-dark";
import { collab, getSyncedVersion, receiveUpdates, sendableUpdates } from "@codemirror/collab";

const lang = StreamLanguage.define(ruby); // Crystal ≈ Ruby, decent highlight

export function mountEditor(el, doc, { editable = true } = {}) {
  const ext = [basicSetup, lang, oneDark];
  if (!editable) ext.push(EditorView.editable.of(false));
  return new EditorView({ parent: el, doc, extensions: ext });
}

/* ---- remote cursors ---- */

const setCursors = StateEffect.define();

class CursorWidget extends WidgetType {
  constructor(name) { super(); this.name = name; }
  eq(other) { return other.name === this.name; }
  toDOM() {
    const el = document.createElement("span");
    el.className = "remote-cursor";
    el.dataset.name = this.name;
    return el;
  }
}

const cursorField = StateField.define({
  create: () => Decoration.none,
  update(deco, tr) {
    for (const e of tr.effects) if (e.is(setCursors)) return e.value;
    return deco.map(tr.changes); // keep positions valid across local edits
  },
  provide: (f) => EditorView.decorations.from(f),
});

function cursorDecorations(view, cursors) {
  const max = view.state.doc.length;
  return Decoration.set(
    [...cursors].map(([name, pos]) =>
      Decoration.widget({ widget: new CursorWidget(name), side: 1 }).range(Math.min(pos, max))
    ),
    true
  );
}

/* ---- collaborative editor ---- */

export function mountCollabEditor(el, { doc, version, slug, name }) {
  const clientID = crypto.randomUUID?.() ?? Math.random().toString(36).slice(2);
  const topic = `room:${slug}`;
  const proto = location.protocol === "https:" ? "wss" : "ws";
  const socket = new WebSocket(`${proto}://${location.host}/ws?name=${encodeURIComponent(name)}`);
  const cursors = new Map();
  let pushing = false;

  const send = (payload) => {
    if (socket.readyState !== WebSocket.OPEN) return; // still connecting — nothing to do
    socket.send(JSON.stringify({ event: "message", topic, payload }));
  };


  function push() {
    if (pushing) return;
    const updates = sendableUpdates(view.state);
    if (!updates.length) return;
    pushing = true;
    send({
      type: "push",
      version: getSyncedVersion(view.state),
      changes: updates.map((u) => ({ clientID: u.clientID, changes: u.changes.toJSON() })),
      doc: view.state.doc.toString(), // server snapshot; it never parses changesets
    });
  }

  const sync = ViewPlugin.fromClass(
    class {
      update(u) {
        if (u.docChanged) push();
        if (u.selectionSet) send({ type: "cursor", name, pos: u.state.selection.main.head });
      }
    }
  );

  const view = new EditorView({
    parent: el,
    doc,
    extensions: [basicSetup, lang, oneDark, collab({ startVersion: version, clientID }), cursorField, sync],
  });

  socket.addEventListener("open", () => {
    socket.send(JSON.stringify({ event: "join", topic, payload: {} }));
    send({ type: "pull", version: getSyncedVersion(view.state) });
  });

  socket.addEventListener("message", ({ data }) => {
    if (typeof data !== "string" || !data.startsWith("{")) return; // heartbeat, not JSON
    const { payload } = JSON.parse(data);
    if (!payload) return;

    // "changes" = direct catch-up from the server.
    // "push"    = another client's edit, rebroadcast with the original envelope.
    if (payload.type === "changes" || payload.type === "push") {
      pushing = false;
      const updates = payload.changes.map((u) => ({
        clientID: u.clientID,
        changes: ChangeSet.fromJSON(u.changes),
      }));
      if (updates.length) view.dispatch(receiveUpdates(view.state, updates));
      push();
    }

    if (payload.type === "cursor" && payload.name !== name) {
      cursors.set(payload.name, payload.pos);
      view.dispatch({ effects: setCursors.of(cursorDecorations(view, cursors)) });
    }
  });

  return view;
}
