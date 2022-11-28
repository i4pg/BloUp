class UsersController < ApplicationController
  before_action :set_user, only: :show
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id) # show users list but exclude the current user
    @friends = current_user.accepted_requests
    @requests = current_user.requests # All pending and accepted
    @friends_requests = FriendRequest.where(id: current_user.request_received)
  end

  def show; end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
