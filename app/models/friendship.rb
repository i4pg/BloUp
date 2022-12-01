class Friendship < ApplicationRecord
  validates_with FriendshipValidator, on: :create

  belongs_to :requester, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  enum :status, %i[pending accepted], default: :pending, null: false

  # See below for more details
  after_update :add_to_user_friends

  private

  # after_commit :prepend_request, on: :create
  # after_commit :send_requests_counter, on: %i[create update destroy]

  def prepend_request
    broadcast_prepend_to([receiver, 'new_request_stream'], target: 'new_request')
  end

  def send_requests_counter
    counter = receiver.received_requests.pending.count

    if counter.zero?
      broadcast_remove_to('friend_requests_count_stream', target: 'requests_counter')
    else
      broadcast_update_to('friend_requests_count_stream', target: 'requests_counter',
                                                          html: counter)
    end
  end

  # When friend request status changed to accepted
  # call this method to make the friendship relation by
  # appending users to each other
  # then call the destroy method to destroy the Friendship record
  # otherwise we'll have a pounch of accepted record that's does not do anything
  def add_to_user_friends
    return unless accepted?

    requester.friends << receiver
    receiver.friends << requester
    destroy!
  end
end
