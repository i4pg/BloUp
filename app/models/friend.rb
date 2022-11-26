class Friend < ApplicationRecord
  validates_with FriendValidator

  belongs_to :requestor_user, class_name: 'User'
  belongs_to :receiver_user, class_name: 'User'
end
