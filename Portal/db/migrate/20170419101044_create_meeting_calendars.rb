class CreateMeetingCalendars < ActiveRecord::Migration[5.0]
  def change
    create_table :meeting_calendars do |t|
      t.bigint :employee_organizer_id
      t.integer :client_organizer_id
      t.string :event_title
      t.date :from_date
      t.time :from_time
      t.time :to_time
      t.datetime :time_zone
      t.text :description
      t.string :meeting_attachment
      t.string :meeting_event_repeat_id
      t.string :meeting_event_notification_id

      t.timestamps
    end
  end
end
