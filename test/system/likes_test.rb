require 'application_system_test_case'

class LikesTest < ApplicationSystemTestCase
  setup do
    # fixture has one like first user first article
    @user1 = users(:one)
    @user2 = users(:two)
    @article1 = articles(:one)
    @article2 = articles(:two)
  end

  test "Increment article's like counter if user first click on like" do
    login_as @user2
    visit articles_url

    assert_difference('@article2.likes.count', +1) do
      click_on 'Likes', match: :first
    end
    assert_selector 'span', text: @article2.likes.count, id: "article_#{@article2.id}"
  end

  test "decrement article's like counter if user already like an article" do
    # fixture has one like first user first article
    # each test run sprit
    login_as @user1
    visit articles_url

    assert_difference('@article1.likes.count', -1) do
      click_on 'Likes', match: :first
    end
    assert_selector 'span', text: @article1.likes.count, id: "article_#{@article1.id}"
  end
end
