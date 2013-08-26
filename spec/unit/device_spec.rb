require 'spec_helper'

describe Device do
  it { should validate_presence_of :app_version }
  it { should ensure_inclusion_of(:operating_system).in_array(['android', 'ios', 'windows'])}

  context "pushable" do
    it "chooses only devices with push token" do
      FactoryGirl.create(:device)
      pushable = FactoryGirl.create(:device, push_token: "nonempty")
      assert_equal [pushable], Device.pushable
    end
  end

  it "should save token on creation" do
    device = FactoryGirl.create(:device)
    device.token.blank?.should == false
  end

  it "should save current date to last_seen at creation" do
    device = FactoryGirl.create(:device)
    device.reload.last_request_at.should be
  end

  it "should update last_request_at when called update_last_request_at!" do
    device = FactoryGirl.create(:device)
    device.update_attributes(last_request_at: 2.days.ago)
    device.update_last_request_at!
    device.reload.last_request_at.today?.should == true
  end
end
