class Team < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates_presence_of :name, :users

  # this is so future generations can make teams support custom images
  def image
    "team.png"
  end
end
