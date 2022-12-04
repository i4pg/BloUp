require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'Comment with commenter' do
    comment = Comment.new(article: articles(:one), body: 'First comment')
    assert_not comment.save
  end

  test 'Comment in an article' do
    comment = Comment.new(commenter: users(:one), body: 'Second Comment')
    assert_not comment.save
  end

  test 'Comment with body' do
    comment = Comment.new(commenter: users(:one), article: articles(:one))
    assert_not comment.save
  end
end
