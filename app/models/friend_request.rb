class FriendRequest < ApplicationRecord
  VALID_STATUSES = %w[accepted ignored pending]

  validates_with FriendRequestValidator, on: :create
  validates :status, inclusion: { in: VALID_STATUSES }

  belongs_to :requestor, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  def accepted?
    status == 'accepted'
  end
end
