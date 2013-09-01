class UserMailer < ActionMailer::Base
  default from: "mobmall@support.com"

  def reset_password_email(user)
    @user = user
    @url  = edit_password_reset_url(user.reset_password_token)

    if @user.password_present?
      subject = "Your password has been reset"
    else
      subject = "Welcome to MobMall!"
    end

    mail(:to => user.email, subject: subject)
  end
end
