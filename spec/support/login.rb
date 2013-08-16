def login(user = InvalidUser.new)
  visit root_path
  fill_in "Email", with: user.email
  fill_in "Password", with: "secret"
  click_button "Login"
end
