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

    context "mod" do
      it "should be accessible from panel" do
        user = FactoryGirl.create(:user)
        local = FactoryGirl.create(:local, moderator: user)
        login(user)
        click_link "Edit local"
        current_path.should == edit_local_path(local)
      end

      it "should allow me to page of my local" do
        user = FactoryGirl.create(:user)
        local = FactoryGirl.create(:local, moderator: user)
        login(user)
        visit edit_local_path(local)
        current_path.should == edit_local_path(local)
      end

      it "should not allow strangers to edit local" do
        user = FactoryGirl.create(:user)
        local = FactoryGirl.create(:local)
        login(user)
        visit edit_local_path(local)
        current_path.should == panel_index_path
      end

      it "should not have moderator select box" do
        user = FactoryGirl.create(:user)
        local = FactoryGirl.create(:local, moderator: user)
        login(user)
        visit edit_local_path(local)
        page.should_not have_selector('select') #expect not to find moderators select field
      end

      it "should be able to update name" do
        user = FactoryGirl.create(:user)
        local = FactoryGirl.create(:local, moderator: user)
        login(user)
        visit edit_local_path(local)
        fill_in "Name", with: "Zara"
        click_button "Update Local"
        Local.all.map(&:name).should == ["Zara"]
      end
    end
  end
end
