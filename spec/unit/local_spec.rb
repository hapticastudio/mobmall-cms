require 'spec_helper'

describe Local do
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should belong_to :moderator }

  context "moderator email" do
    it "is nil if no mod" do
      Local.new.moderator_email.should be_nil
    end

    it "is moderators email if mod is present" do
      local = Local.new
      mod = FactoryGirl.build(:user)
      local.moderator = mod
      local.moderator_email.should == mod.email
    end
  end

  context "content versioning" do
    it "should allow partial updates" do
      local = FactoryGirl.create(:local)
      local.update_attributes(description: "Tasty om nom noms")
      local.contents.last.confirm!

      local = Local.where(id: local.id).last

      local.description.should == "Tasty om nom noms"
      local.name.should == "MacDonalds"
    end

    it "changes are not used without confirmation" do
      local = FactoryGirl.create(:local)
      local.update_attributes(name: "KFC")
      Local.where(id: local.id).first.name.should == "MacDonalds"
    end

    it "should create new content object if changes present" do
      local = FactoryGirl.create(:local)
      expect do 
        local.update_attributes(description: "Tasty om nom noms")
      end.to change{local.contents.count}.from(1).to(2)
    end

    it "should not create new content if no changes" do
      local = FactoryGirl.create(:local)
      expect do 
        local.update_attributes(description: "")
      end.not_to change{local.contents.count}
    end
  end
end
