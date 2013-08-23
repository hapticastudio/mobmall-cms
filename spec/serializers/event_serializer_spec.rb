require 'spec_helper'

describe EventSerializer do
  before(:each) do
    event = FactoryGirl.create(:event)
    @serializer = EventSerializer.new(event)
  end

  it "has 5 attributes" do
    @serializer.attributes.length.should == 5
  end

  it "serializes id" do
    @serializer.attributes.should include(:id)
  end

  it "serializes local_id" do
    @serializer.attributes.should include(:local_id)
  end

  it "serializes description" do
    @serializer.attributes.should include(:description)
  end

  it "serializes begin_time" do
    @serializer.attributes.should include(:begin_time)
  end

  it "serializes end_time" do
    @serializer.attributes.should include(:end_time)
  end

  it "does not include root" do
    @serializer.root_name.should be_false
  end
end
