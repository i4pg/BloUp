class LikesController < ApplicationController
  before_action :set_params
  before_action :authenticate_user!

  def create
    if @user.likes.find_by(article: @article).nil?
      @like = @article.likes.create(user: @user)

      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.update("article_#{@article.id}", @article.likes.count) }
        # format.html { redirect_to articles_path, notice: 'Like' } if @like.save
      end
    else
      destroy
    end
  end

  def destroy
    @like = @user.likes.find_by(article: @article)

    @like.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update("article_#{@article.id}", @article.likes.count) }
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  private

  def set_params
    @article = Article.find(params[:article_id])
    @user = current_user
  end
end
