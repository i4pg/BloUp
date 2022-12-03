require 'application_system_test_case'

class LikesTest < ApplicationSystemTestCase
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @user3 = users(:three)

    @article1 = articles(:one)
    @article2 = articles(:two)
    @article3 = articles(:three)

    login_as users(:two)
  end

  test 'when like button clicked add a like to article and increment the counter on the page' do
    visit articles_url

    assert_difference('@article2.likes.count', +1) do
      click_on 'Like', match: :first
    end
    assert_selector 'like', text: @article2.likes.count
  end
end
