require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase
  setup do
    @requestor = users(:three)
    @receiver = users(:two)

    # build user first request
    @requestor.requested_friends.build(receiver_id: @receiver.id).save
  end

  test 'Requestor can only send one request' do
    request = @requestor.requested_friends.create(receiver_id: @receiver.id)
    assert_not request.save, 'Requestor can send more than one request'
  end

  test 'Receiver can not send a request once again ' do
    request = @receiver.requested_friends.create(receiver_id: @requestor.id)
    assert_not request.save, 'Receiver can send request once again'
  end
end
