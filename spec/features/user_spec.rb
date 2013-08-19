require 'spec_helper'

describe "user" do
  context "admin rights" do
    it "allows promoting to admin" do
      login_as_admin
      another_user = FactoryGirl.create(:user)
      visit users_path
      click_button "Promote"
      another_user.reload.admin?.should be_true
    end

    it "allows degrading to moderator" do
      login_as_admin
      another_user = FactoryGirl.create(:admin)
      visit users_path
      click_button "Degrade"
      another_user.reload.admin?.should be_false
    end
  end

  context "index" do
    it "should not pass unauthenticated user" do
      visit users_path
      page.should have_content("Login to access this page")
    end

    it "should not pass non-admin users" do
      user = FactoryGirl.create(:user)
      login(user)
      visit users_path
      page.should have_content("You don't have permission to visit this page")
    end

    it "should allow admins" do
      login_as_admin
      visit users_path
      current_path.should == users_path
    end

    it "should follow to locals edit page via moderator name" do
      user  = FactoryGirl.create(:user)
      local = FactoryGirl.create(:local, moderator: user)
      login_as_admin
      visit users_path
      click_link local.name
      current_path.should == edit_local_path(local)
    end
  end

  context "edit" do
    it "should show 'Edit account' link when logged in" do
      user = FactoryGirl.create(:user)
      login(user)
      page.should have_link("Edit account")
    end

    it "should visit edit_user_path on 'Edit account' link" do
      user = FactoryGirl.create(:user)
      login(user)
      click_link "Edit account"
      current_path.should == edit_user_path(user)
    end

    it "should allow user to his own edit page" do
      user = FactoryGirl.create(:user)
      login(user)
      visit edit_user_path(user)
      current_path.should == edit_user_path(user)
    end

    it "should not allow user to strager edit page" do
      user = FactoryGirl.create(:user)
      login(user)
      visit edit_user_path(FactoryGirl.create(:user))
      current_path.should == panel_index_path
    end

    it "Should redirect to panel on successfull password update" do
      user = FactoryGirl.create(:user)
      login(user)
      visit edit_user_path(user)
      fill_in "Password", with: "New password"
      fill_in "Password confirmation", with: "New password"
      click_button "Update User"
      page.should have_content("Account updated successfully")
      current_path.should == panel_index_path
    end

    it "should be able to login with new password" do
      user = FactoryGirl.create(:user)
      login(user)
      visit edit_user_path(user)
      fill_in "Password", with: "New password"
      fill_in "Password confirmation", with: "New password"
      click_button "Update User"
      click_link "Log out"
      
      fill_in "Email", with: user.email
      fill_in "Password", with: "New password"
      click_button "Login"
      current_path.should == panel_index_path
    end
  end

  context "new" do
    it "should not pass unauthenticated user" do
      visit new_user_path
      page.should have_content("Login to access this page")
    end

    it "should not pass non-admin users" do
      user = FactoryGirl.create(:user)
      login(user)
      visit new_user_path
      page.should have_content("You don't have permission to visit this page")
    end

    it "allows admin to enter the page" do
      login_as_admin
      visit new_user_path
      current_path.should == new_user_path
    end
  end

  context "create" do
    it "sends an email to the user" do
      login_as_admin
      visit new_user_path
      fill_in "Email", with: "some@mail.com"
      click_button "Create User"
      ActionMailer::Base.deliveries.any?.should be_true
      ActionMailer::Base.deliveries.last.to.should == ["some@mail.com"]
    end

    it "renders :new in case of problems" do
      login_as_admin
      visit new_user_path
      User.any_instance.stub(save: false)
      fill_in "Email", with: "some@mail.com"
      click_button "Create User"
      page.should have_content "Create new user"
    end

    it "redirects to panel on success" do
      login_as_admin
      visit new_user_path
      fill_in "Email", with: "some@mail.com"
      click_button "Create User"
      current_path.should == panel_index_path
    end

    it "creates user without password on success" do
      login_as_admin
      visit new_user_path
      fill_in "Email", with: "some@mail.com"
      expect{click_button "Create User"}.to change{User.count}.from(1).to(2)
      User.last.password_present?.should be_false
    end
  end

  context "destroy", js: true do
    it "admin should be able to remove user" do
      login_as_admin
      user_to_delete = FactoryGirl.create(:user)
      visit users_path
      popup.confirm {
        click_button "Delete"
      }
      sleep 0.1
      User.count.should == 1
    end

    it "does not remove user if confirmation is dismissed" do
      login_as_admin
      user_to_delete = FactoryGirl.create(:user)
      visit users_path
      popup.dismiss {
        click_button "Delete"
      }
      sleep 0.1
      User.count.should == 2
    end
  end
end
