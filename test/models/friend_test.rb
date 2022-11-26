require 'test_helper'

class FriendTest < ActiveSupport::TestCase
  setup do
    @requestor_user = users(:three)
    @receiver_user = users(:two)

    # build user first friendship
    @requestor_user.made_requests.build(receiver_user_id: @receiver_user.id).save
  end

  test 'Friendship should not be duplicated' do
    request = @requestor_user.made_requests.create(receiver_user_id: @receiver_user.id)
    assert_not request.save, 'Friendship are duplicated'
  end

  test 'User accept a friend request, should not be a requestor once again' do
    request = @receiver_user.made_requests.create(receiver_user_id: @requestor_user.id)
    assert_not request.save, 'Receiver of friendship can be a requestor once again'
  end
end
