require 'spec_helper'

describe Local::Content do
  it { should belong_to :local }

  context "to_hash" do
    it "returns name and description in hash" do
      content = Local::Content.new(name: "Clark Kent", description: "He secretly is a spiderman")
      content.to_hash.should == {
        name: "Clark Kent", 
        description: "He secretly is a spiderman"
      }
    end
  end

  context "confirm!" do
    it "sets confirmed to true" do
      content = Local::Content.new
      content.confirm!
      content.confirmed.should be_true
    end
  end
end
