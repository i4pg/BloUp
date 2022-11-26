class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: %i[update destroy]
  before_action :authenticate_user!

  # POST /friend_requests or /friend_requests.json
  def create
    @friend_request = current_user.requested_friends.create(friend_request_params)
    redirect_to users_path
  end

  # PATCH/PUT /friend_requests/1 or /friend_requests/1.json
  def update
    respond_to do |format|
      if @friend_request.update(friend_request_params)
        format.html do
          redirect_to friend_request_url(@friend_request), notice: 'Friend request was successfully updated.'
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
      format.html { redirect_to friend_requests_url, notice: 'Friend request was successfully destroyed.' }
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
    params.permit(:requestor_id, :receiver_id, :status)
  end
end
