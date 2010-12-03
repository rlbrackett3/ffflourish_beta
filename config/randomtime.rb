class Time
  def self.random(years_back=1)
    year = Time.now.year - rand(years_back) - 1
    month = rand(12) + 1
    day = rand(31) + 1
    Time.local(year, month, day)
  end
end

