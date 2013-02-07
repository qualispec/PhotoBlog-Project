class AddCookieTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :cookie_token, :string
    add_index :users, :cookie_token, :unique => true
  end
end
