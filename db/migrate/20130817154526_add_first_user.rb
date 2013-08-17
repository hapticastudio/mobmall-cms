class AddFirstUser < ActiveRecord::Migration
  def up
    User.create(email: "l.strzebinczyk@gorailsgo.com", password: "secret", password_confirmation: "secret", role: 'admin')
  end

  def down
    User.destroy_all
  end
end
