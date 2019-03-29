module ApplicationHelper
	def is_select_week(week,day)
    (week..week.end_of_week).include?(day)
  end

  def is_select_day(select_day,day)
    select_day == day
  end

  def time_diff(start_time, end_time)
  	seconds_diff = (start_time - end_time).to_i.abs

  	hours = seconds_diff / 3600
  	seconds_diff -= hours * 3600

  	minutes = seconds_diff / 60
  	seconds_diff -= minutes * 60

  	seconds = seconds_diff

  	"#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end
end