require 'spec_helper'

describe "panel" do
  it "should not allow unauthenticated users" do
    visit panel_index_path
    current_path.should == root_path
    page.should have_content("Login to access this page")
  end

  context "new user" do
    it "should show link to admin" do
      user = FactoryGirl.create(:admin)
      login(user)
      visit panel_index_path
      page.should have_link("New user")
    end

    it "should follow to new_user_path" do
      user = FactoryGirl.create(:admin)
      login(user)
      visit panel_index_path
      click_link("New user")
      current_path.should == new_user_path
    end

    it "should not show link to moderator" do
      user = FactoryGirl.create(:user)
      login(user)
      visit panel_index_path
      page.should_not have_link("New user")
    end
  end

  context 'Users list' do
    it "should follow to users_path" do
      user = FactoryGirl.create(:admin)
      login(user)
      visit panel_index_path
      click_link("Users list")
      current_path.should == users_path
    end
  end
end
