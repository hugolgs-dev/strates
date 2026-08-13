import { EditorView, basicSetup } from "codemirror";
import { StreamLanguage } from "@codemirror/language";
import { ruby } from "@codemirror/legacy-modes/mode/ruby";
import { oneDark } from "@codemirror/theme-one-dark";

const lang = StreamLanguage.define(ruby); // Crystal ≈ Ruby, decent highlight

export function mountEditor(el, doc, { editable = true } = {}) {
  const ext = [basicSetup, lang, oneDark];
  if (!editable) ext.push(EditorView.editable.of(false));
  return new EditorView({ parent: el, doc, extensions: ext });
}
