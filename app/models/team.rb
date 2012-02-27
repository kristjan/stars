class Team < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates_presence_of :name, :users
end
