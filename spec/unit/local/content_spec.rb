require 'spec_helper'

describe Local::Content do
  context "to_hash" do
    it "returns name and description in hash" do
      content = Local::Content.new(name: "Clark Kent", description: "He secretly is a spiderman")
      content.to_hash.should == {
        name: "Clark Kent", 
        description: "He secretly is a spiderman"
      }
    end
  end
end
