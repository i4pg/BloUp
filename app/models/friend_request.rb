class FriendRequest < ApplicationRecord
  validates_with FriendRequestValidator

  belongs_to :requestor, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
end
