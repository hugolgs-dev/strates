class Room < Grant::Base
  connection primary
  table rooms
  column slug : String, primary: true, auto: false
  column content : String
  column version : Int32 = 0
  timestamps
end
