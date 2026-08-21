require "../spec_helper"

describe Room do
  it "uses the rooms table" do
    room = Room.new
    room.class.table_name.should eq("rooms")
  end
end
