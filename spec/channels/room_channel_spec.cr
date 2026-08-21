require "../spec_helper"

describe RoomChannel do
  it "can be instantiated" do
    channel = RoomChannel.new("room:lobby")
    channel.should_not be_nil
  end
end
