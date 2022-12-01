class UsersController < ApplicationController
  before_action :set_user, only: :show
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id) # show users list but exclude the current user
    @pending_requests = current_user.pending_requests # All pending and accepted
    # Pending Requests Received
    @friends_requests = Friendship.where(id: current_user.requests_received)
  end

  def show; end

  private

  def set_user
    @user = User.find(params[:id])
    @articles = @user.articles.order('created_at ASC')
  end
end
