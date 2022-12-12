class Like < ApplicationRecord
  validates :user_id, uniqueness: { scope: :article_id }
  belongs_to :user
  belongs_to :article

  after_commit :likes_counter

  def likes_counter
    broadcast_update_to('like_stream', target: "likes article_#{article.id}", html: article.likes.count)
  end
end
