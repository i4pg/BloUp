class Comment < ApplicationRecord
  validates :body, presence: true
  belongs_to :commenter, class_name: 'User'
  belongs_to :article
end
