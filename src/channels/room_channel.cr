# WebSocket channel for room communication.
#
# Clients subscribe to this channel through a ClientSocket.
# Messages sent to this channel are handled by `handle_message`.
#
# See: https://github.com/amberframework/amber/blob/v2.0.0-beta.4/docs/guides/websockets.md
# src/channels/room_channel.cr
class RoomChannel < Amber::WebSockets::Channel
  @@log  = Hash(String, Array(JSON::Any)).new { |h, k| h[k] = [] of JSON::Any }
  @@base = Hash(String, Int32).new

  def handle_message(client_socket, msg)
    slug = msg["topic"].as_s.split(":").last
    p    = msg["payload"]

    case p["type"].as_s
    when "pull"
      send_changes(client_socket, msg["topic"].as_s, slug, p["version"].as_i)
    when "push"
      unless p["version"].as_i == version(slug) # stale — send the catch-up so the client rebases
        send_changes(client_socket, msg["topic"].as_s, slug, p["version"].as_i)
        return
      end
      @@log[slug].concat(p["changes"].as_a)
      broadcast(msg)
      persist(slug, p["doc"].as_s) if p["doc"]?
    when "cursor"
      broadcast(msg)
    end
  end

  private def broadcast(msg)
    rebroadcast!({
      "event"   => msg["event"].as_s,
      "topic"   => msg["topic"].as_s,
      "payload" => msg["payload"],
    })
  end

  private def send_changes(client_socket, topic, slug, from)
    client_socket.socket.send({
      event:   "changes",
      topic:   topic,
      payload: {
        type: "changes",
        version: version(slug),
        changes: @@log[slug][(from - base(slug))..]? || [] of JSON::Any,
      },
    }.to_json)
  end

  private def base(slug)
    @@base[slug] ||= Room.find_by(slug: slug).try(&.version) || 0
  end

  private def version(slug)
    base(slug) + @@log[slug].size
  end

  private def persist(slug, doc)
    room = Room.find(slug) || Room.new(slug: slug)
    room.content = doc
    room.version = version(slug)
    room.save
  end
end
