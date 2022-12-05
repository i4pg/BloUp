require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @article1 = articles(:one)
    @user1 = users(:one)
  end

  test 'post a create comment request' do
    assert_difference('@article1.comments.count', +1) do
      body = 'somebody'
      post article_comments_url(article_id: @article1.id, comment: { body: })
    end
    assert_redirected_to article_url(@article1)
  end
end
