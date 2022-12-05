class CommentsController < ApplicationController
  before_action :set_article
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params.merge(article_id: @article.id)).save!
    redirect_to article_url(@article)
    flash[:alert] = 'Comment was successfully created.'
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :commenter_id, :article_id)
  end
end
