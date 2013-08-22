require 'spec_helper'

describe Device do
  it { should validate_presence_of :app_version }

  it "should save token on creation" do
    device = FactoryGirl.create(:device)
    device.token.blank?.should == false
  end

  it "should return token as json" do
    device = FactoryGirl.create(:device)
    device.as_json.should == {
      'device' => {
        'token' => device.token
      }
    }
  end
end
