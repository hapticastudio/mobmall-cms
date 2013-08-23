require 'spec_helper'

describe TagSerializer do
  before(:each) do
    local = FactoryGirl.create(:local, tag_list: "tag")
    tag = local.tags.first
    @serializer = TagSerializer.new(tag)
  end

  it "has 3 attributes" do
    @serializer.serializable_hash.length.should == 3
  end

  it "serializes id" do
    @serializer.serializable_hash.should include(:id)
  end

  it "serializes name" do
    @serializer.serializable_hash.should include(:name)
  end

  it "serializes local_ids" do
    @serializer.serializable_hash.should include(:local_ids)
  end

  it "does not include root" do
    @serializer.root_name.should be_false
  end
end
