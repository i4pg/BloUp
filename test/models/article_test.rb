require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test 'should not save article without body' do
    article = Article.new
    assert_not article.save, 'Saved the article without a body'
  end
  test 'should report error' do
    # some_undefined_variable is not defined elsewhere in the test case
    assert_raises(NameError) do
      some_undefined_variable
    end
  end
end
