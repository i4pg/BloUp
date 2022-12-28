class AddArticlableToArticle < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :articleble, polymorphic: true, null: false
  end
end
