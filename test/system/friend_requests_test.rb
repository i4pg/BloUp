require "application_system_test_case"

class FriendRequestsTest < ApplicationSystemTestCase
  setup do
    @friend_request = friend_requests(:one)
  end

  test "visiting the index" do
    visit friend_requests_url
    assert_selector "h1", text: "Friend requests"
  end

  test "should create friend request" do
    visit friend_requests_url
    click_on "New friend request"

    fill_in "Receiver", with: @friend_request.receiver_id
    fill_in "Requestor", with: @friend_request.requestor_id
    fill_in "Status", with: @friend_request.status
    click_on "Create Friend request"

    assert_text "Friend request was successfully created"
    click_on "Back"
  end

  test "should update Friend request" do
    visit friend_request_url(@friend_request)
    click_on "Edit this friend request", match: :first

    fill_in "Receiver", with: @friend_request.receiver_id
    fill_in "Requestor", with: @friend_request.requestor_id
    fill_in "Status", with: @friend_request.status
    click_on "Update Friend request"

    assert_text "Friend request was successfully updated"
    click_on "Back"
  end

  test "should destroy Friend request" do
    visit friend_request_url(@friend_request)
    click_on "Destroy this friend request", match: :first

    assert_text "Friend request was successfully destroyed"
  end
end
