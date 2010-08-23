class CreateSeconds < ActiveRecord::Migration
  def self.up
    create_table :seconds do |t|
      t.integer :star_id
      t.integer :user_id
      t.timestamps
    end

    add_index :seconds, [:star_id, :user_id], :unique => true
  end

  def self.down
    drop_table :seconds
  end
end
