require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    login_as users(:one)
    @user = users(:one)
    @user_2 = users(:two)
  end

  test 'visiting the index' do
    visit users_path

    assert_selector '.title', text: @user_2.username
  end

  test 'Sending friend requests' do
    assert_difference('FriendRequest.count', +1) do
      visit users_path

      assert_selector '.title', text: @user_2.username
      click_on 'Send request', match: :first
    end
  end

  test 'Visit user profile' do
    visit user_url(@user)

    assert_selector '.title', text: @user.username
  end
end
