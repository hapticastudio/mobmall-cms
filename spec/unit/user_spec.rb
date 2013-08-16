require 'spec_helper'

describe User do
  it { should validate_uniqueness_of :email }
  it { should validate_presence_of :email }

  it "should validate confirmation of password" do
    user = User.new
    user.password = "secret"
    user.password_confirmation = "incorrect"
    user.valid?
    assert user.errors.messages[:password_confirmation].include?("doesn't match Password")
  end
end
