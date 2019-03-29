class CreateMeetingEventRepeats < ActiveRecord::Migration[5.0]
  def change
    create_table :meeting_event_repeats do |t|
      t.string :name
      t.string :short_name

      t.timestamps
    end
  end
end