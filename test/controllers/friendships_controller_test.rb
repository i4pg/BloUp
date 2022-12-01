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
           params: { receiver: users(:three), requestor: users(:two) }
    end

    # assert_redirected_to users_path
  end

  # test 'should update friendship' do
  #   patch friendship_url(@friendship),
  #         params: { requestor_id: users(:two).id, receiver_id: users(:three).id, status: 'accepted' }
  #   assert_redirected_to friendships_url
  # end

  # test 'should destroy friendship' do
  #   assert_difference('Friendship.count', -1) do
  #     delete friendship_url(@friendship)
  #   end

  #   assert_redirected_to friendships_url
  # end
end
