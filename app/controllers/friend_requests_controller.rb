class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: %i[show edit destroy update]
  before_action :authenticate_user!

  # GET /friend_requests or /friend_requests.json
  def index
    @friend_requests = FriendRequest.where(id: current_user.request_received.where(status: 'pending'))
    @friends = current_user.accepted_requests
  end

  # GET /friend_requests/1 or /friend_requests/1.json
  def show; end

  # POST /friend_requests or /friend_requests.json
  def create
    @friend_request = current_user.requested_friends.create(friend_request_params)

    respond_to do |format|
      if @friend_request.save
        format.html do
          redirect_to users_path, notice: 'Friend request sent.'
        end
        format.json { render :show, status: :created, location: @friend_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friend_requests/1 or /friend_requests/1.json
  def update
    # @friend_request = current_user.requested_friends.find(params[:friend_request]).update(status: 'accepted')

    respond_to do |format|
      if @friend_request.update(friend_request_params)
        format.html do
          flash.now[:notice] = 'Friend request accepted.'
          redirect_to friend_requests_path
        end
        format.json { render :show, status: :ok, location: @friend_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friend_requests/1 or /friend_requests/1.json
  def destroy
    @friend_request.destroy

    respond_to do |format|
      format.html { redirect_to friend_requests_path, alert: 'Friend request was ignored.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def friend_request_params
    params.permit(:receiver_id, :requestor_id, :status)
  end
end
