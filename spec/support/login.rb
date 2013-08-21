def login(user = InvalidUser.new)
  visit root_path
  fill_in "Email", with: user.email
  fill_in "Password", with: "secret"
  click_button "Login"
end

def login_as_admin
  if @controller.present? #functional tests
    admin = FactoryGirl.build_stubbed(:admin)
    login_user(admin)
  else
    user = FactoryGirl.create(:admin)
    login(user)
  end
end

def login_as_user
  if @controller.present? #functional tests
    user = FactoryGirl.build_stubbed(:user)
    login_user(user)
  else
    user = FactoryGirl.create(:user)
    login(user)
  end
end
