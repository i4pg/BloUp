require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
  end

  test 'should get index' do
    get friendships_url
    assert_response :success
  end

  test 'should send a friend request' do
    assert_difference('Friendship.count', +1) do
      post friendships_url,
           params: { receiver_id: users(:three).id, requester_id: users(:two).id, status: :pending }
    end
    # assert_redirected_to users_path
  end

  test 'should destroy friendship record after accept' do
    assert_difference('Friendship.count', -1) do
      patch friendship_url(friendships(:one)),
            params: { status: :accepted }
    end
    # assert_redirected_to friendships_url
  end

  test 'should destroy friendship directly when ignoring the request' do
    assert_difference('Friendship.count', -1) do
      delete friendship_url(friendships(:one))
    end

    # assert_redirected_to friendships_url
  end
end
