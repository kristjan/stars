class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string  :name
      t.boolean :active, :default => true

      t.timestamps
    end

    create_table :teams_users, :id => false do |t|
      t.integer :user_id, :null => false
      t.integer :team_id, :null => false
    end
    add_index :teams, :name, :unique => true

	  add_index :teams_users, :user_id
	  add_index :teams_users, :team_id
  end

  def self.down
    drop_table :teams
    drop_table :teams_users
  end
end
