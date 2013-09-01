require 'spec_helper'

describe EventSerializer do
  before(:each) do
    event = FactoryGirl.create(:event)
    @serializer = EventSerializer.new(event)
  end

  it "has 5 attributes" do
    @serializer.serializable_hash.length.should == 7
  end

  it "serializes id" do
    @serializer.serializable_hash.should include(:id)
  end

  it "serializes local_id" do
    @serializer.serializable_hash.should include(:local_id)
  end

  it "serializes description" do
    @serializer.serializable_hash.should include(:description)
  end

  it "serializes name" do
    @serializer.serializable_hash.should include(:name)
  end

  it "serializes short_description" do
    @serializer.serializable_hash.should include(:short_description)
  end

  it "serializes begin_time" do
    @serializer.serializable_hash.should include(:begin_time)
  end

  it "serializes end_time" do
    @serializer.serializable_hash.should include(:end_time)
  end

  it "does not include root" do
    @serializer.root_name.should be_false
  end
end
