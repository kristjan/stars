class Superstar
  attr_accessor :user

  def self.during(week, limit=nil)
    superstars = User.all.map{|u| new(u, week)}.select(&:active?).sort
    limit ? superstars.first(limit) : superstars
  end

  def self.last_week
    during(1.week.ago, 3)
  end

  def self.this_week
    during(Time.now)
  end

  def initialize(user, week)
    @user = user
    @monday = week.beginning_of_week.to_date
  end

  def active?
    value > 0
  end

  def monday
    @monday
  end

  def next_monday
    @monday + 1.week
  end

  def num_stars
    stars.size
  end

  def num_seconds
    seconds.size
  end

  def seconds
    @seconds ||= stars.map(&:seconds).flatten
  end

  def stars
    @stars ||= user.stars.during(week)
  end

  def value
    stars.map(&:value).sum
  end

  def week
    monday..next_monday
  end

  def <=>(other)
    -(sort_data <=> other.sort_data)
  end

  def sort_data
    [value, stars.size, seconds.size]
  end

end
