 class YearlyHolidayCalendarController < ApplicationController
	before_action :set_holiday, only: [:show, :edit, :update, :destroy]
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
				render pdf: "YearlyHolidayCalendar", disposition: 'attachment',
        # layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
	end

	def create
		@yearly_holiday_calendar = YearlyHolidayCalendar.new(yearly_holiday_calendar_params)
		respond_to do |format|
			if @yearly_holiday_calendar.save
				format.html {redirect_to yearly_holiday_calendar_index_path(month: @yearly_holiday_calendar.holiday_date), notice: "Yearly Holiday was successfully created."}
			else
				format.html {redirect_to yearly_holiday_calendar_index_path, notice: @yearly_holiday_calendar.errors.full_messages.join('. ')+ " (#{yearly_holiday_calendar_params[:holiday_date]})"}
			end
		end
	end

	def edit
		@month = params[:month].present? ? params[:month].to_date : Time.now
		@yearly_holiday_calendars = YearlyHolidayCalendar.all.where('holiday_date >= ? && holiday_date <= ?', @month.beginning_of_year, @month.end_of_year).order('holiday_date asc')
	end

	def update
		respond_to do |format|
			if @yearly_holiday_calendar.update(yearly_holiday_calendar_params)
				format.html {redirect_to yearly_holiday_calendar_index_path(month: @yearly_holiday_calendar.holiday_date)}
			else
				format.html {redirect_to edit_yearly_holiday_calendar_path(@yearly_holiday_calendar), notice: @yearly_holiday_calendar.errors.full_messages.join('.') + " (#{yearly_holiday_calendar_params[:holiday_date]})"}
			end
		end
	end

	def destroy
		@yearly_holiday_calendar.destroy
		@month = params[:month].present? ? params[:month].to_date : Time.now
		redirect_to yearly_holiday_calendar_index_path(month: @month)
	end

	private

	def set_holiday
		@yearly_holiday_calendar = YearlyHolidayCalendar.find_by(id: params[:id])  
	end

	def yearly_holiday_calendar_params
		params.require(:yearly_holiday_calendar).permit(:holiday_date, :description)
	end
end
