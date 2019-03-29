class YearlyHolidayCalendarController < ApplicationController
	def index
		@yearly_holiday_calendar = YearlyHolidayCalendar.new
		@month = params[:month].present? ? params[:month].to_date : Time.now
		@yearly_holiday_calendars = YearlyHolidayCalendar.all.where('holiday_date >= ? && holiday_date <= ?', @month.beginning_of_year, @month.end_of_year).order('holiday_date asc')
		respond_to do |format|
      format.html
      format.js
      format.csv { send_data @yearly_holiday_calendars.to_csv }
      format.xls { send_data @yearly_holiday_calendars.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "yearly_holiday_calendars", disposition: 'attachment',
        # layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
	end

	private

	def yearly_holiday_calendar_params
		params.require(:yearly_holiday_calendar).permit(:holiday_date, :description)
	end
end
