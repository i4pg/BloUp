class AddFriendToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :friend, foreign_key: { to_table: :users }
  end
end
