class CreateYearlyHolidayCalendars < ActiveRecord::Migration[5.0]
  def change
    create_table :yearly_holiday_calendars do |t|
      t.date :holiday_date
      t.text :description

      t.timestamps
    end
  end
end
