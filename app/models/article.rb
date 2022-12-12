class Article < ApplicationRecord
  validates :body, presence: true

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # 1. partial 'articles/_article'
  # 2. look for turbo stream with id 'article_stream'
  # 3. inserts_by append,prepend,remove,update,before,after
  # 4. target turbo frame or div to prepend or append what so ever
  broadcasts_to lambda { |article|
                  [article.user, 'article_stream']
                }, inserts_by: :prepend, target: 'created_article'
end
