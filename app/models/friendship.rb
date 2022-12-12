class Friendship < ApplicationRecord
  validates_with FriendshipValidator, on: :create

  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
