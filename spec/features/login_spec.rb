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

  private

  def login(user = InvalidUser.new)
    visit root_url
    fill_in "Email", with: user.email
    fill_in "Password", with: "secret"
    click_button "Login"
  end
end
