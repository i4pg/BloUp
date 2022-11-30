class UsersController < ApplicationController
  before_action :set_user, only: :show
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id) # show users list but exclude the current user
    @requests = current_user.requests # All pending and accepted
    # Pending Requests Received
    @friends_requests = FriendRequest.where(id: current_user.request_received)
  end

  def show; end

  private

  def set_user
    @user = User.find(params[:id])
    @articles = @user.articles.order('created_at ASC')
  end
end
