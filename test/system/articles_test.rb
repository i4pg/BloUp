require 'application_system_test_case'

class ArticlesTest < ApplicationSystemTestCase
  setup do
    login_as users(:three)
    @article3 = articles(:three)
  end

  test 'login logout buttons' do
    visit articles_url
    assert_text 'Logout'
    assert_text 'Profile'
    logout
    visit articles_url
    assert_text 'Login'
    assert_text 'Sign Up'
  end

  test 'visiting the index' do
    visit articles_url
    assert_selector 'div'
  end

  test 'should create article' do
    visit articles_url
    click_on 'New article'

    fill_in 'article_body', with: @article3.body
    click_on 'Create Article'

    assert_text @article3.body
  end

  test 'should update Article' do
    visit article_url(@article3)
    click_on 'Edit', match: :first

    fill_in 'article_body', with: @article3.body
    click_on 'Update Article'

    assert_text @article3.body
    click_on 'Back'
  end

  test 'should destroy Article' do
    visit article_url(@article3)

    assert_difference('Article.count', -1) do
      click_on 'Remove', match: :first
    end
  end
end
