require 'test_helper'

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
  end

  test 'should get index' do
    get friend_requests_url
    assert_response :success
  end

  test 'should send a friend request' do
    assert_difference('FriendRequest.count', +1) do
      post friend_requests_url,
           params: { receiver_id: users(:three).id, requester_id: users(:two).id, status: :pending }
    end
    # assert_redirected_to users_path
  end

  test 'should destroy friend_request record after accept' do
    assert_difference('FriendRequest.count', -1) do
      patch friend_request_url(friend_requests(:one)),
            params: { status: :accepted }
    end
    # assert_redirected_to friend_requests_url
  end

  test 'should destroy friend_request directly when ignoring the request' do
    assert_difference('FriendRequest.count', -1) do
      delete friend_request_url(friend_requests(:one))
    end

    # assert_redirected_to friend_requests_url
  end
end
