class Users::RegistrationsCallbacksController < Devise::RegistrationsController
  def create
    super
    UserMailer.with(user: @user).welcome_email.deliver_later if @user.persisted?
  end
end
