require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    login_as users(:three)
    @user = users(:one)
  end

  test 'visiting the index' do
    visit users_path

    assert_selector '.title', text: @user.username
  end
end
