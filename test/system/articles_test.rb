require 'application_system_test_case'

class ArticlesTest < ApplicationSystemTestCase
  setup do
    login_as users(:three)
    @article = articles(:six)
  end

  test 'visiting the index' do
    visit articles_url
    assert_selector 'div'
  end

  test 'should create article' do
    visit articles_url
    click_on 'New article'

    fill_in 'article_body', with: @article.body
    click_on 'Create Article'

    assert_text @article.body
  end

  test 'should update Article' do
    visit article_url(@article)
    click_on 'Edit', match: :first

    fill_in 'article_body', with: @article.body
    click_on 'Update Article'

    assert_text @article.body
    click_on 'Back'
  end

  test 'should destroy Article' do
    visit article_url(@article)

    assert_difference('Article.count', -1) do
      click_on 'Remove', match: :first
      # assert_text 'Article was successfully destroyedd', 'HA'
    end
  end
end
