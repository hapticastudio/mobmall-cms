require 'spec_helper'

describe "user" do
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
      user = FactoryGirl.create(:admin)
      login(user)
      visit new_user_path
      current_path.should == new_user_path
    end
  end

  context "create" do
    it "sends an email to the user" do
      user = FactoryGirl.create(:admin)
      login(user)
      visit new_user_path
      fill_in "Email", with: "some@mail.com"
      click_button "Create User"
      ActionMailer::Base.deliveries.any?.should be_true
      ActionMailer::Base.deliveries.last.to.should == ["some@mail.com"]
    end

    it "renders :new in case of problems" do
      user = FactoryGirl.create(:admin)
      login(user)
      visit new_user_path
      User.any_instance.stub(save: false)
      fill_in "Email", with: "some@mail.com"
      click_button "Create User"
      page.should have_content "Create new user"
    end

    it "redirects to panel on success" do
      user = FactoryGirl.create(:admin)
      login(user)
      visit new_user_path
      fill_in "Email", with: "some@mail.com"
      click_button "Create User"
      current_path.should == panel_index_path
    end

    it "creates user without password on success" do
      user = FactoryGirl.create(:admin)
      login(user)
      visit new_user_path
      fill_in "Email", with: "some@mail.com"
      expect{click_button "Create User"}.to change{User.count}.from(1).to(2)
      User.last.password_present?.should be_false
    end
  end
end
