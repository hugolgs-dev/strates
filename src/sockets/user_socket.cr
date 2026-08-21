struct UserSocket < Amber::WebSockets::ClientSocket
  channel "room:*", RoomChannel

  def on_connect : Bool
    session[:name] = params["name"]?.to_s.strip.presence || "anon"
    true
  end
end
