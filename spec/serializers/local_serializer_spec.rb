require 'spec_helper'

describe EventSerializer do
  before(:each) do
    local = FactoryGirl.create(:local)
    @serializer = LocalSerializer.new(local)
  end

  it "has 3 attributes" do
    @serializer.attributes.length.should == 3
  end

  it "serializes id" do
    @serializer.attributes.should include(:id)
  end

  it "serializes name" do
    @serializer.attributes.should include(:name)
  end

  it "serializes description" do
    @serializer.attributes.should include(:description)
  end

  it "does not include root" do
    @serializer.root_name.should be_false
  end
end
