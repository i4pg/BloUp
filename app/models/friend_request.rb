class FriendRequest < ApplicationRecord
  VALID_STATUSES = %w[accepted pending]

  validates_with FriendRequestValidator, on: :create
  validates :status, inclusion: { in: VALID_STATUSES }

  belongs_to :requestor, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  after_commit :send_requests_counter, on: %i[create update destroy]

  def send_requests_counter
    broadcast_update_to('friend_requests_count_stream', target: 'requests_counter',
                                                        html: receiver.request_received.where(status: 'pending'))
  end

  def accepted?
    status == 'accepted'
  end
end
