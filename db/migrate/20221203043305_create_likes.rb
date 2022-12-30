class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :liker, null: false, foreign_key: { to_table: :users }
      t.references :liked_article, null: false, foreign_key: { to_table: :articles }

      t.timestamps
    end
    add_index :likes, %i[liker_id liked_article_id], unique: true
  end
end
