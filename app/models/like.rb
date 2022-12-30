class Like < ApplicationRecord
  validates :liker_id, uniqueness: { scope: :liked_article_id }
  belongs_to :liker, class_name: 'User'
  belongs_to :liked_article, class_name: 'Article'

  after_commit :likes_counter

  def likes_counter
    broadcast_update_to('like_stream', target: "likes article_#{liked_article.id}", html: liked_article.likes.count)
  end
end
