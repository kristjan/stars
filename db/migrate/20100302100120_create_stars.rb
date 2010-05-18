class CreateStars < ActiveRecord::Migration
  def self.up
    create_table :stars do |t|
      t.integer :from_id
      t.integer :to_id
      t.string :reason

      t.timestamps
    end
  end

  def self.down
    drop_table :stars
  end
end
