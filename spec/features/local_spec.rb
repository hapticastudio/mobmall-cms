require 'spec_helper'

describe "local" do
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
    end

    it "creates no locals when incorrect data passed" do
      login_as_admin
      visit new_local_path
      fill_in "Name", with: "x" * 51
      click_button "Create Local"
      Local.count.should == 0
    end
  end
end
