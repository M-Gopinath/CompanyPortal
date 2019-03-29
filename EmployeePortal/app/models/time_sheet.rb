class TimeSheet < ApplicationRecord
	require 'csv'
	belongs_to :task
	belongs_to :employee
	belongs_to :time_sheet_status
	validate :unique_time_sheet, on: :create

	scope :approved?, -> {where(time_sheet_status_id: 1)}
	scope :cancelled?, -> {where(time_sheet_status_id: 2)}
	scope :undefined?, -> {where(time_sheet_status_id: nil)}

	def unique_time_sheet
		@employee = Employee.find_by(id: employee_id)
		if @employee.present?
			time_sheets = @employee.time_sheets.where(entry_date: entry_date)
			time_sheets = time_sheets.where("start_time >= ? and start_time <= ?",start_time,end_time)
			errors.add(:start_time, "Already entry the time") if time_sheets.count > 0
		else
			errors.add(:employee_id, "must be employee")
		end
	end

	def entry_date?
		entry_date.present? ? entry_date.strftime("%d-%m-%Y") : "No date"
	end

	def employee?
		employee.name?
	end

	def start_time?
		start_time.present? ? start_time.strftime("%H:%M%P") : "No Time"
	end

	def end_time?
		end_time.present? ? end_time.strftime("%H:%M%P") : "No Time"
	end

	def hours_taken?
		hours_taken.present? ? hours_taken.strftime("%H:%M") : "No Time"
	end

	def status?
		time_sheet_status_id.present? ? time_sheet_status.try(:name) : "-"
	end

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
	      csv << ["Employee Id", "First Name", "Last Name", "Email","Task","Entry Date","Start time","End Time", "Hours Taken"]
	      all.each do |time_sheet|
	        csv << [time_sheet.employee.employee_id, time_sheet.employee.first_name, time_sheet.employee.last_name, time_sheet.employee.email, time_sheet.task == 0 ? "Other" : time_sheet.try(:task).try(:title), time_sheet.try(:entry_date), time_sheet.try(:start_time?), time_sheet.try(:end_time?), time_sheet.hours_taken.present? ? time_sheet.employee.hours_format(time_sheet.hours_taken) : "0"]
	      end
	    end
	end
end
