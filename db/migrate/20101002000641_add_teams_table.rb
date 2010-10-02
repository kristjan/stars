class AddTeamsTable < ActiveRecord::Migration
  def self.up
	create_table :teams do |t|
	  t.string :name, :null => false
	end

	create_table :teams_users, :id => false do |t|
		t.integer :team_id, :null => false
		t.integer :user_id, :null => false
	end

  end

  def self.down
	drop_table :teams
	drop_table :teams_users
  end
end
