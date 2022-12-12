require 'application_system_test_case'

class FriendRequestsTest < ApplicationSystemTestCase
  setup do
    FriendRequest.destroy_all
    login_as users(:one)
  end

  test 'should send friend request' do
    visit users_url
    assert_selector 'span', text: 'Friends'
    assert_difference('FriendRequest.count', +1) do
      click_on 'Send request', match: :first
    end
    assert_selector 'span', class: 'button', text: ''
  end

  test 'should destroy Friend request when ignore clicked' do
    # Idk i've to repeat sending request process
    visit users_url
    assert_selector 'span', text: 'Friends'
    assert_difference('FriendRequest.count', +1) do
      click_on 'Send request', match: :first
    end
    assert_selector 'span', class: 'button', text: ''

    # login as second user to accept the first test request
    login_as users(:two)
    visit friend_requests_path
    assert_selector 'h1', text: 'Friends Requests'
    assert_difference('FriendRequest.count', -1) do
      click_on 'Ignore request', match: :first
    end
  end

  test 'should accept friend request and requestor show in the friends list when receiver click accept' do
    # Idk i've to repeat sending request process
    login_as users(:one)
    visit users_url
    assert_selector 'span', text: 'Friends'
    assert_difference('FriendRequest.count', +1) do
      click_on 'Send request', match: :first
    end
    assert_selector 'span', class: 'button', text: ''

    login_as users(:two)
    visit friend_requests_path
    assert_selector 'h1', text: 'Friends Requests'
    assert_difference('FriendRequest.count', -1) do
      click_on 'Accept request', match: :first
      assert_selector 'h1', text: 'Friends List'
      assert_selector 'div', text: '@' + users(:one).username
    end
  end
end
