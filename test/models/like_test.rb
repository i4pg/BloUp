require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @user3 = users(:three)
    @article1 = articles(:one)
    @article2 = articles(:two)
    @article3 = articles(:three)
  end

  test 'User able to like article' do
    like = @user2.likes.create(article: @article1)
    assert like.save, 'User unable to like'
  end

  test 'Should not like more than one' do
    like = @user1.likes.create(article: @article1)
    assert_not like.save, 'User able to like more than once'
  end
end
