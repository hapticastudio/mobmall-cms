require 'spec_helper'

describe "local" do
  context "index" do
    it "should allow admin via 'locals list' Link" do
      login_as_admin
      click_link "Locals list"
      current_path.should == locals_path
    end

    it "should be able to click 'Edit' at locals" do
      local = FactoryGirl.create(:local)
      login_as_admin
      visit locals_path
      click_link "Edit local"
      current_path.should == edit_local_path(local)
    end
  end

  context "create" do
    it "should allow admin to #new page via link" do
      login_as_admin
      click_link "New local"
      current_path.should == new_local_path
    end

    it "should allow admin to create a local" do
      login_as_admin
      visit new_local_path
      fill_in "Name", with: "MacDonalds"
      click_button "Create Local"
      Local.count.should == 1
      Local.last.name.should == "MacDonalds"
      current_path.should == edit_local_path(Local.last)
    end

    it "creates no locals when incorrect data passed" do
      login_as_admin
      visit new_local_path
      fill_in "Name", with: "x" * 51
      click_button "Create Local"
      Local.count.should == 0
    end
  end

  context "edit" do
    context "admin" do
      it "should see current data" do
        local = FactoryGirl.create(:local)
        login_as_admin
        visit edit_local_path(local)
        page.should have_content(local.name)
      end

      it "should be able to set moderator in edit page" do
        local = FactoryGirl.create(:local)
        user  = FactoryGirl.create(:user)
        login_as_admin
        visit edit_local_path(local)
        select user.email, from: "local_user_id"
        click_button "Update Local"
        local.reload.moderator.should == user
      end
    end
  end
end
