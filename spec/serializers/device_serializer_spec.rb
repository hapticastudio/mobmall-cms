require 'spec_helper'

describe DeviceSerializer do
  before(:each) do
    device = FactoryGirl.create(:device)
    @serializer = DeviceSerializer.new(device)
  end

  it "has 1 attribute" do
    @serializer.attributes.length.should == 1
  end

  it "serializes token" do
    @serializer.attributes.should include(:token)
  end
end
