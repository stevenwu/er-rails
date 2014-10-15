class UserMailer < ActionMailer::Base
  default from: "hello@stamford.com"

  def welcome_user(user)
    @user = user
    mail(to: @user.email,
        subject: 'Welcome to Stamford Bridge') do |format|
      format.html { render 'welcome_email' }
    end
  end
end
