require 'spec_helper'

describe Local do
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should belong_to :moderator }

  context "moderator email" do
    it "is nil if no mod" do
      Local.new.moderator_email.should be_nil
    end

    it "is moderators email if mod is present" do
      local = Local.new
      mod = FactoryGirl.create(:user)
      local.moderator = mod
      local.moderator_email.should == mod.email
    end
  end
end
