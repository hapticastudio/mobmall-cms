require 'spec_helper'

describe EventSerializer do
  before(:each) do
    local = FactoryGirl.create(:local)
    @serializer = LocalSerializer.new(local)
  end

  it "has 3 attributes" do
    @serializer.serializable_hash.length.should == 4
  end

  it "serializes id" do
    @serializer.serializable_hash.should include(:id)
  end

  it "serializes name" do
    @serializer.serializable_hash.should include(:name)
  end

  it "serializes description" do
    @serializer.serializable_hash.should include(:description)
  end

  it "serializes poi" do
    @serializer.serializable_hash.should include(:poi)
  end

  it "does not include root" do
    @serializer.root_name.should be_false
  end
end
