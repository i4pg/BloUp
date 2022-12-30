class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.text :body

      t.timestamps
    end
  end
end
