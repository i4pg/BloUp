require 'test_helper'

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @friend_request = FriendRequest.create(receiver_id: users(:three).id,
                                           requestor_id: users(:two).id).save
  end

  test 'should get index' do
    get friend_requests_url
    assert_response :success
  end

  # test 'should create friend_request' do
  #   assert_difference('FriendRequest.count') do
  #     post friend_requests_url,
  #          params: { receiver_id: users(:one).id, requestor_id: users(:two).id }
  #   end

  #   assert_redirected_to users_path
  # end

  # test 'should update friend_request' do
  #   patch friend_request_url(@friend_request),
  #         params: { requestor_id: users(:two).id, receiver_id: users(:three).id, status: 'accepted' }
  #   assert_redirected_to friend_requests_url
  # end

  # test 'should destroy friend_request' do
  #   assert_difference('FriendRequest.count', -1) do
  #     delete friend_request_url(@friend_request)
  #   end

  #   assert_redirected_to friend_requests_url
  # end
end
