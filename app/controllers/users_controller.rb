class UsersController < ApplicationController
  before_action :set_user, only: :show
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id) # show users list but exclude the current user
    @pendings = current_user.pendings.ids
    @friends = current_user.friends
    @ids = current_user.pending_ids
  end

  def show; end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
