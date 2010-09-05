class LengthenReasonField < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      ALTER TABLE stars
      CHANGE COLUMN reason reason varchar(1024)
    SQL
  end

  def self.down
    execute <<-SQL
      ALTER TABLE stars
      CHANGE COLUMN reason reason varchar(256)
    SQL
  end
end
