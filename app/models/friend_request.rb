class FriendRequest < ApplicationRecord
  validates_with FriendRequestValidator, on: :create

  belongs_to :requester, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  enum :status, %i[pending accepted], default: :pending, null: false

  # See below for more details
  after_update :accepted!

  private

  # after_commit :prepend_request, on: :create
  # after_commit :send_requests_counter
  broadcasts_to lambda { |request|
                  [request.receiver, 'new_request_stream']
                }, inserts_by: :prepend, target: 'new_request', on: :create

  def send_requests_counter
    counter = receiver.received_requests.pending.count

    if counter.zero?
      broadcast_remove_to([receiver, 'requests_count_stream'], target: 'requests_counter')
    else
      broadcast_update_to([receiver, 'requests_count_stream'], target: 'requests_counter',
                                                               html: counter)
    end
  end

  # When friend request status changed to accepted
  # call this method to make the friend_request relation by
  # appending users to each other
  # then call the destroy method to destroy the FriendRequest record
  # otherwise we'll have a pounch of accepted record that's does not do anything
  def accepted!
    return unless accepted? && id == receiver.id

    receiver.friendship.build(friend: requester).save!
    requester.friendship.build(friend: receiver).save!
    destroy!
  end
end
