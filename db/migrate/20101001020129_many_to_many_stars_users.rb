class ManyToManyStarsUsers < ActiveRecord::Migration
  def self.up
    create_table :stars_users, :id => false do |t|
      t.integer :user_id, :null => false
      t.integer :star_id, :null => false
    end
	add_index :stars_users, :user_id
	add_index :stars_users, :star_id

	Star.all.each do |star|
	  star.to << User.find(star.to_id)
    end

	remove_column :stars, :to_id
	
  end

  def self.down
	add_column :stars, :to_id, :integer, :null => false

	# pick the first id from each multi-"to" star to backport
	Star.all.each do |star|
	  star.to_id = star.to.first.id
	end

    drop_table :stars_users
  end
end
