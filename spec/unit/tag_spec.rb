require 'spec_helper'

describe Tag do
  it { should have_many :locals }

  it "should be updated when tagging is added" do
    tag = FactoryGirl.create(:tag, updated_at: 2.days.ago)
    local = FactoryGirl.create(:local)
    local.tag_list = tag.name
    local.save
    (tag.reload.updated_at - Time.now).abs.should < 1
  end

  it "should be updated when tagging is removed", focus: true do
    local = FactoryGirl.create(:local)
    tag = FactoryGirl.create(:tag, locals: [local])
    tag_to_be_updated = FactoryGirl.create(:tag, updated_at: 2.days.ago, locals: [local])

    local.tag_list = tag.name

    (tag_to_be_updated.reload.updated_at - Time.now).abs.should < 1
  end
end
