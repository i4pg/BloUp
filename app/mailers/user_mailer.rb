class UserMailer < ApplicationMailer
  default from: 'BloUp@team.info'

  def welcome_email
    @user = params[:user]
    @url = 'https://BloUp.com/sign_in'
    mail(to: @user.email, subject: 'Welcome to BloUp')
  end
end
