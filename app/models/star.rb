class Star < ActiveRecord::Base
  default_scope :include => :seconds, :order => 'id desc'

  validates_presence_of :from, :to, :reason

  belongs_to :from, :class_name => 'User'

  has_and_belongs_to_many :to, :class_name => 'User'

  has_many :seconds

  named_scope :during, lambda { |range|
    start = range.first.to_time.utc
    finish = range.last.to_time.utc
    {:conditions => {:created_at => start..finish}}
  }
  named_scope :recent, lambda { |count|
    count ||= 10
    {:order => 'id desc', :limit => count}
  }

  # note that this is not "to_sentence" as in "convert star to sentence"
  # but is instead "the sentence representing :to"
  def to_sentence
    names = to.map {|u| u.name }
	names.to_sentence
  end

  def self.past_week_by_user
    Star.all(:conditions => {:created_at => 1.week.ago..Time.now}).
         group_by(&:to).
         sort_by {|(user, stars)| stars.size}.reverse
  end

  def num_seconds
    seconds.count
  end

  def seconded_by?(user)
    !!seconds.detect{|s| s.user == user}
  end

  def value
    1 + num_seconds/2.0
  end

  after_create do |star|
    Mailer.deliver_star(star)
  end
end
