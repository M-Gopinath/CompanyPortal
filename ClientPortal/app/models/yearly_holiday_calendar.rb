class YearlyHolidayCalendar < ApplicationRecord
	require 'csv'
  def self.options_for_sorted_by
  	[
  		['Email (ZA)', 'email_desc'],
  		['Email (AZ)', 'email_asc'],
  		['Created date (newest first)', 'created_at_desc'],
  		['Created date (oldest first)', 'created_at_asc']
  	]
  end
  def self.to_csv(options = {})
  	CSV.generate(options) do |csv|
  		csv << ["YearlyHolidayCalendar Holiday Date", "YearlyHolidayCalendar	 Description"]
  		all.each do |al|
  			csv << [al.holiday_date, al.description]
  		end
  	end
  end
end
