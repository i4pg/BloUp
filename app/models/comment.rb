class Comment < ApplicationRecord
  validates :body, presence: true

  belongs_to :commenter, class_name: 'User'
  belongs_to :article

  # 1. partial 'comments/_comment'
  # 2. look for turbo stream with id 'comment_stream'
  # 3. inserts_by append,prepend,remove,update,before,after
  # 4. target turbo frame or div to prepend or append what so ever
  broadcasts_to ->(comment) { [comment.article, 'comment_stream'] }, inserts_by: :prepend, target: 'comments'
end
