class UsersController < ApplicationController
  before_action :set_user, only: :show
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id)
    @requests = current_user.request_received.all
  end

  def show; end

  def edit; end

  def update; end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
