class LengthenReasonField < ActiveRecord::Migration
  def self.up
    change_column :stars, :reason, :string, :limit => 1024
  end

  def self.down
    change_column :stars, :reason, :string
  end
end
