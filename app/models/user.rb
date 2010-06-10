class User < ActiveRecord::Base
  acts_as_authentic

  has_many :stars, :foreign_key => :to_id

  named_scope :active, :conditions => {:active => true}

  def self.by_recent_stars
    User.all.sort_by do |user|
      star = user.most_recent_star
      (star.created_at if star).to_i
    end.reverse
  end

  def most_recent_star
    stars.recent.first
  end

  def others
    User.active.all(:conditions => ["`users`.`id` != ?", self.id])
  end
end
