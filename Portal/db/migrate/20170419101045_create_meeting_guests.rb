class CreateMeetingGuests < ActiveRecord::Migration[5.0]
  def change
    create_table :meeting_guests do |t|
      t.integer :meeting_calendar_id
      t.bigint :employee_guest_id
      t.integer :client_guest_id

      t.timestamps
    end
  end
end
