require "../config/*"
require "./controllers/**"
require "./models/**"
require "./schemas/**"
require "./jobs/**"
require "./mailers/**"
require "./channels/**"
require "./sockets/**"

Amber::Server.start
