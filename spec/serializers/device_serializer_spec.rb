require 'spec_helper'

describe DeviceSerializer do
  before(:each) do
    device = FactoryGirl.create(:device)
    @serializer = DeviceSerializer.new(device)
  end

  it "has 1 attribute" do
    @serializer.serializable_hash.length.should == 1
  end

  it "serializes token" do
    @serializer.serializable_hash.should include(:token)
  end
end
