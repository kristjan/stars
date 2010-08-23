class Star < ActiveRecord::Base
  belongs_to :from, :class_name => 'User'
  belongs_to :to,   :class_name => 'User'

  named_scope :recent, lambda { |count|
    count ||= 10
    {:order => 'id desc', :limit => count}
  }

  def self.past_week_by_user
    Star.all(:conditions => {:created_at => 1.week.ago..Time.now}).
         group_by(&:to).
         sort_by {|(user, stars)| stars.size}.reverse
  end

  after_create do |star|
    Mailer.deliver_star(star)
  end
end
