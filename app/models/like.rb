class Like < ApplicationRecord
  validates :user_id, uniqueness: { scope: :article_id }
  belongs_to :user
  belongs_to :article
  after_commit :likes_counter

  private

  def likes_counter
    broadcast_update_to(article, target: article, html: article.likes.count)
  end
end
