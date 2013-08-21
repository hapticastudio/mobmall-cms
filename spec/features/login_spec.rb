require 'spec_helper'

describe "login" do
  it "should show warning when incorrect credentials passed" do
    visit root_path
    click_button "Login"
    page.should have_content("Invalid email or password")
  end
end
