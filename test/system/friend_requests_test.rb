require 'application_system_test_case'

class FriendRequestsTest < ApplicationSystemTestCase
  setup do
    login_as users(:one)
  end

  test 'visiting the index' do
    visit friend_requests_url

    assert_selector 'h1', text: 'Friends Requests'
  end

  test 'should send friend request' do
    visit users_url
    assert_selector 'span', text: 'Friends'
    assert_difference('FriendRequest.count', +1) do
      click_on 'Send request', match: :first
    end
  end

  test 'should destroy Friend request when ignore clicked' do
    # login as second user to accept the first test request
    visit users_url
    assert_selector 'span', text: 'Friends'
    assert_difference('FriendRequest.count', +1) do
      click_on 'Send request', match: :first
    end
    login_as users(:two)
    visit friend_requests_url
    assert_selector 'h1', text: 'Friends Requests'
    assert_difference('FriendRequest.count', -1) do
      click_on 'Ignore request', match: :first
    end
  end

  test 'should accept friend request and requestor show in the friends list when receiver click accept' do
    login_as users(:one)
    visit users_url
    assert_selector 'span', text: 'Friends'
    assert_difference('FriendRequest.count', +1) do
      click_on 'Send request', match: :first
    end
    login_as users(:two)
    visit friend_requests_url
    assert_selector 'h1', text: 'Friends Requests'
    click_on 'Accept request', match: :first
    assert FriendRequest.last.status == 'accepted'
    assert_selector 'h1', text: 'Friends List'
    assert_selector 'div', text: '@' + users(:one).username
  end
end
