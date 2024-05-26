class UserPasswordDigest < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :password_digst, :string
    remove_column :users, :password, :string
  end
end
