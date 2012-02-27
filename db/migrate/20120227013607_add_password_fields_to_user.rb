class AddPasswordFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :crypted_password, :string
    add_column :users, :password_salt, :string
  end

  def self.down
    remove_column :users, :crypted_password
    remove_column :users, :password_salt
  end
end
