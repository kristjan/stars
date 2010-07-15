class ChangeFacebookUidToBigInt < ActiveRecord::Migration
  def self.up
    execute(<<-SQL)
      ALTER TABLE users
      CHANGE COLUMN facebook_uid
      facebook_uid BIGINT UNSIGNED
    SQL
  end

  def self.down
    execute(<<-SQL)
      ALTER TABLE users
      CHANGE COLUMN facebook_uid
      facebook_uid INTEGER
    SQL
  end
end
