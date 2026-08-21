Amber::Server.configure do
  pipeline :web do
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Logger.new
    plug Amber::Pipe::Session.new
    plug Amber::Pipe::Flash.new
    plug Amber::Pipe::CSRF.new
  end

  pipeline :static do
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Static.new("./public")
  end

  pipeline :api do
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Logger.new
  end

  routes :web do
    get "/", SnippetsController, :index
    post "/:slug/fork", SnippetsController, :fork, {"slug" => /[a-zA-Z0-9]{8}/}
    get "/:slug", SnippetsController, :show, {"slug" => /[a-zA-Z0-9]{8}/}
    websocket "/ws", UserSocket
  end

  routes :static do
    get "/*", Amber::Controller::Static, :index
  end

  routes :api do
    post "/strates", SnippetsController, :create
    post "/:slug/save", SnippetsController, :save, {"slug" => /[a-zA-Z0-9]{8}/}
  end
end
