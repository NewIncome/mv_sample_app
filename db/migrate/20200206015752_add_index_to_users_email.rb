class AddIndexToUsersEmail < ActiveRecord::Migration[6.0]
  def change
    # This adds an index on the "email" column of the "users table".
    add_index :users, :email, unique: true
  end
end
