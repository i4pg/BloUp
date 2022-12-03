require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @article1 = articles(:one)
    @article2 = articles(:two)
  end

  test 'should like an article' do
    assert_difference('@article2.likes.count', +1) do
      login_as @user2
      post likes_url(article_id: @article2.id)
    end
  end

  test 'should remove a like from an article' do
    # fixture has first article first user
    assert_difference('@article1.likes.count', -1) do
      login_as @user1
      post likes_url(article_id: @article1.id)
    end
  end
end
