class User < ActiveRecord::Base
  acts_as_authentic

  has_many :stars, :foreign_key => :to_id

  named_scope :active, :conditions => {:active => true}

  Superstar = Struct.new(:user, :count, :seconds, :stars)
  def self.superstars_for(week, limit=nil)
    monday = week.beginning_of_week
    stars = Star.during(monday..(monday + 1.week))
    superstars = stars.group_by(&:to).map do |user, stars|
      Superstar.new(user, stars.size, stars.map(&:num_seconds).sum, stars)
    end.sort_by do |superstar|
      # Sort by stars+seconds, ties go to the one with more stars
      [superstar.count + superstar.seconds, superstar.count]
    end.reverse
    limit.nil? ? superstars : superstars.first(limit)
  end

  def can_second?(star)
    return false if [star.from, star.to].include?(self)
    return false if seconded?(star)
    return true
  end

  def most_recent_star
    stars.recent.first
  end

  def others
    User.active.all(:conditions => ["`users`.`id` != ?", self.id])
  end

  def second(star)
    Second.create(:star => star, :user => self) if can_second?(star)
  end

  def seconded?(star)
    star.seconded_by?(self)
  end
end
