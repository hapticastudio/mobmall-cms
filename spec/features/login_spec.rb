require 'spec_helper'

describe "login" do
  it "should show warning when incorrect credentials passed" do
    visit root_url
    fill_in "Email", with: "example@email.com"
    fill_in "Password", with: "secret"
    click_button "Login"
    page.should have_content("Invalid email or password")
  end

  it "should redirect to panel when successfully signed in" do
    user = FactoryGirl.create(:user)
    visit root_url
    fill_in "Email", with: user.email
    fill_in "Password", with: "secret"
    click_button "Login"
    current_path.should == panel_index_path
  end
end
