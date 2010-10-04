class User < ActiveRecord::Base
  acts_as_authentic

  has_and_belongs_to_many :stars
  has_and_belongs_to_many :teams

  named_scope :active, :conditions => {:active => true}

  def can_second?(star)
    return false if [star.from, star.to.flatten].include?(self)
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
