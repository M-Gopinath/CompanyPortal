module ApplicationHelper
	def is_select_week(week,day)
    (week..week.end_of_week).include?(day)
  end

  def is_select_day(select_day,day)
    select_day == day
  end
end
