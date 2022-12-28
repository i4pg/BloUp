class Article < ApplicationRecord
  validates :body, presence: true, if: -> { articleble_type == 'Text' }
  validates_with LinkValidator, if: -> { articleble_type == 'Image' && !image.attached? }
  validates :image, attached: true,
                    content_type: { in: ['image/png', 'image/jpeg'], message: 'is invalid' }, if: lambda {
                                                                                                    articleble_type == 'Image' && link.empty?
                                                                                                  }

  before_create :upload_image_via_link, if: -> { articleble_type == 'Image' && !image.attached? }

  has_one_attached :image

  belongs_to :articleble, polymorphic: true
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

  def upload_image_via_link
    url = link
    tempimage = Down.download(url)
    filename = tempimage.original_filename
    image.attach(io: tempimage, filename:)
  end
end
