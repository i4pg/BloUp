require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should not get index without login' do
    get users_url
    assert_redirected_to(new_user_session_path)
    sign_in users(:one)
    get users_url
    assert_response :success
  end

  test 'should not get show without login' do
    get user_url(id: users(:two).id)
    assert_redirected_to(new_user_session_path)
    sign_in users(:one)
    get user_url(id: users(:two).id)
    assert_response :success
  end
end
