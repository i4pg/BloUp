class FriendRequest < ApplicationRecord
  # VALID_STATUSES = %i[accepted pending]

  validates_with FriendRequestValidator, on: :create
  # validates :status, inclusion: { in: VALID_STATUSES }

  belongs_to :requestor, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  # scope :friends, -> { where(status: 'accepted') }
  # scope :pending, -> { where(status: 'pending') }
  enum :status, %i[accepted pending]

  # after_create_commit lambda { |_friend_request|
  #                       [receiver, 'new_request_stream']
  #                     }, inserts_by: :prepend, target: 'new_request'

  after_commit :prepend_request, on: :create
  after_commit :send_requests_counter, on: %i[create update destroy]

  # Add last request to the friend request page imedietly
  def prepend_request
    broadcast_prepend_to([receiver, 'new_request_stream'], target: 'new_request')
  end

  def send_requests_counter
    counter = receiver.request_received.where(status: :pending).count
    if counter.zero?
      broadcast_remove_to('friend_requests_count_stream', target: 'requests_counter')
    else
      broadcast_update_to('friend_requests_count_stream', target: 'requests_counter',
                                                          html: counter)
    end
  end
end
