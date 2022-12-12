class FriendRequest < ApplicationRecord
  validates_with FriendRequestValidator, on: :create

  belongs_to :requester, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  enum :status, %i[pending accepted], default: :pending, null: false

  after_update :make_friendship!

  after_commit :send_requests_counter

  broadcasts_to lambda { |request|
                  [request.receiver, 'new_request_stream']
                }, inserts_by: :prepend, target: 'new_request', on: :create

  private

  def send_requests_counter
    counter = receiver.received_requests.pending.count

    if counter.zero?
      broadcast_remove_to([receiver, 'requests_count_stream'], target: 'requests_counter')
    else
      broadcast_update_to([receiver, 'requests_count_stream'], target: 'requests_counter',
                                                               html: counter)
    end
  end

  def make_friendship!
    return unless accepted?

    receiver.friendships.build(friend: requester).save!
    requester.friendships.build(friend: receiver).save!
    destroy!
  end
end
