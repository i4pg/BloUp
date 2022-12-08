require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase
  setup do
    @requester = users(:one)
    @receiver = users(:two)
  end

  test 'The receiver can not send a request to the requestor once again' do
    request = @receiver.sent_requests.build(receiver: @requester)
    assert_not request.save, 'receiver can send request once again'
  end

  test 'User Should not request him self' do
    request = @requester.sent_requests.create(receiver: @requester)
    assert_not request.save, 'Users are able to request himself'
  end
end
