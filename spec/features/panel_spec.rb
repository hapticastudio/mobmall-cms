require 'spec_helper'

describe "panel" do
  it "should not allow unauthenticated users" do
    visit panel_index_path
    current_path.should == root_path
    page.should have_content("Login to access this page")
  end
end
