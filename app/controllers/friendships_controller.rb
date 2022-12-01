class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[show edit destroy update]
  before_action :authenticate_user!

  # GET /friendships or /friendships.json
  def index
    @friendships = current_user.received_requests.includes(:requester).pending
    @friends = current_user.friends
    @pendings = current_user.pendings.includes(:receiver).ids
    @ids = current_user.pending_ids
  end

  # GET /friendships/1 or /friendships/1.json
  def show; end

  # POST /friendships or /friendships.json
  def create
    @friendship = current_user.sent_requests.create(friendship_params)

    respond_to do |format|
      if @friendship.save!
        # format.turbo_stream
        format.html { redirect_to users_path, notice: 'Friend request sent.' }
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friendships/1 or /friendships/1.json
  def update
    # @friendship = current_user.sent_requests.find(params[:friendship]).update(status: :accepted)

    respond_to do |format|
      if @friendship.update(friendship_params)
        format.html { redirect_to friendships_path, notice: 'Friend request accepted.' }
        format.json { render :show, status: :ok, location: @friendship }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /friendships/1 or /friendships/1.json
  def destroy
    @friendship.destroy

    respond_to do |format|
      format.html { redirect_to friendships_path, alert: 'Friend request was ignored.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def friendship_params
    params.permit(:receiver_id, :requester_id, :status)
  end
end
