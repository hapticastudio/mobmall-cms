require 'spec_helper'

describe User do
  it { should validate_uniqueness_of :email }
  it { should validate_presence_of :email }

  it { should have_one :local }

  it "should validate confirmation of password" do
    user = User.new
    user.password = "secret"
    user.password_confirmation = "incorrect"
    user.valid?
    assert user.errors.messages[:password_confirmation].include?("doesn't match Password")
  end

  context "promote" do
    it "sets role to admin" do
      user = FactoryGirl.build(:user)
      user.promote!
      user.role.should == "admin"
    end
  end

  context "degrade" do
    it "sets role to nil" do
      user = FactoryGirl.build(:admin)
      user.degrade!
      user.role.should == 'moderator'
    end
  end

  context "admin?" do
    it "returns false if role is not 'admin" do
      FactoryGirl.build(:user).admin?.should be_false
    end

    it "returns true if role is 'admin" do
      FactoryGirl.build(:admin).admin?.should be_true
    end
  end

  context "password_present?" do
    it "returns false if crypted_password is not saved" do
      User.new.password_present?.should be_false
    end

    it "returns true if crypted_password is saved" do
      FactoryGirl.create(:user).password_present?.should be_true
    end
  end
end
