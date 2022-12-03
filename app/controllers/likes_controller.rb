class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = current_user
    @article = Article.find(params[:article_id])
    @like = @user.likes.create(like_params)

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Like' } if @like.save
    end
  end

  def destroy
    # @like = @user.likes.destroy(like_params)
    @like = Like.find(params[:id])
    @like.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'like' }
      format.json { head :no_content }
    end
  end

  private

  def like_params
    params.permit(:user_id, :article_id)
  end
end
