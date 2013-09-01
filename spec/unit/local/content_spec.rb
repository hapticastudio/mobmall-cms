require 'spec_helper'

describe Local::Content do
  it { should belong_to :local }

  context "to_hash" do
    it "returns name and description in hash" do
      content = FactoryGirl.build(:local_content, name: "Clark Kent", description: "He secretly is a spiderman")
      content.to_hash.should == {
        name: "Clark Kent",
        description: "He secretly is a spiderman"
      }
    end
  end

  context "confirm!" do
    it "sets confirmed to true" do
      content = FactoryGirl.create(:local_content)
      content.confirm!
      content.confirmed.should be_true
    end

    it "updates local in relation" do
      local = FactoryGirl.create(:local, updated_at: 2.days.ago)
      local_content = FactoryGirl.create(:local_content, local: local)
      local_content.confirm!
      (local.reload.updated_at - Time.now).abs.should < 1
    end
  end
end
