class Like < ApplicationRecord
  validates :user_id, uniqueness: { scope: :article_id }
  belongs_to :user
  belongs_to :article
  after_commit :likes_counter

  def likes_counter
    counter = article.likes.count
    broadcast_update_to(article, target: article, html: counter)
  end
end
