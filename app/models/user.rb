class User < ActiveRecord::Base
  acts_as_authentic

  has_many :stars, :foreign_key => :to_id

  named_scope :active, :conditions => {:active => true}

  Superstar = Struct.new(:user, :count, :stars)
  def self.superstars_for(week, limit=3)
    monday = week.beginning_of_week
    stars = Star.during(monday..(monday + 1.week))
    stars.group_by(&:to).map do |user, stars|
      Superstar.new(user, stars.size, stars)
    end.sort_by{|superstar| -superstar.count}.first(limit)
  end

  def most_recent_star
    stars.recent.first
  end

  def others
    User.active.all(:conditions => ["`users`.`id` != ?", self.id])
  end
end
