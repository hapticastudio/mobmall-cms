require 'spec_helper'

describe "login" do
  it "should show warning when incorrect credentials passed" do
    login
    page.should have_content("Invalid email or password")
  end

  it "should redirect to panel when successfully signed in" do
    user = FactoryGirl.create(:user)
    login(user)
    current_path.should == panel_index_path
  end

  it "redirects signed in users to panel" do
    user = FactoryGirl.create(:user)
    login(user)
    visit root_url
    current_path.should == panel_index_path
  end

  it "allows to log out" do
    user = FactoryGirl.create(:user)
    login(user)
    click_link "Log out"
    page.should have_content("Logged out!")
  end
end
