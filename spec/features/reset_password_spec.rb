require 'spec_helper'

describe "reset password" do
  it "should show information after filling form" do
    send_password_email
    page.should have_content("Instructions have been sent to your email.")
  end

  it "should send an email to me" do
    user = FactoryGirl.create(:user)
    send_password_email(user)
    deliveries = ActionMailer::Base.deliveries
    assert deliveries.any?
    deliveries.last.to.should == [user.email]
  end

  it "should update reset_password_token at found user" do
    user = FactoryGirl.create(:user)
    send_password_email(user)
    assert user.reload.reset_password_token
  end

  it "updates the password correctly" do
    user = FactoryGirl.create(:user)
    send_password_email(user)
    user.reload
    visit edit_password_reset_path(user.reset_password_token)
    fill_in "Password", with: "new_password"
    fill_in "Password confirmation", with: "new_password"
    click_button "Update User"

    fill_in "Email", with: user.email
    fill_in "Password", with: "new_password"
    click_button "Login"

    current_path.should == panel_index_path
  end

  private

  def send_password_email(user = InvalidUser.new)
    visit new_password_reset_path
    fill_in "Email", with: user.email
    click_button "Reset my password!"
  end
end
