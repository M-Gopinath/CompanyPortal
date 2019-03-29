class MeetingCalendarController < ApplicationController
  
  def index
    p session[:calendar_view]
    @sel_date = date = params[:date].present? ? Date.parse(params[:date]) : Time.zone.now.to_date
    @dbeg = @week = session[:calendar_view] == "month" ? date.beginning_of_month.at_beginning_of_week : date.at_beginning_of_week
    @dend = @sel_date.end_of_month
    @days_from_this_week = (@week.at_beginning_of_week..@week.at_end_of_week)
  end

  # def full_calendar
  # end


  def show_month
    @sel_date = Date.parse(params[:date])
    @dbeg = @sel_date.beginning_of_month.beginning_of_week
    @dend = @sel_date.end_of_month
  end
end
