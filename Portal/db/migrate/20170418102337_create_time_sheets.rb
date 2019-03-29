class CreateTimeSheets < ActiveRecord::Migration[5.0]
  def change
    create_table :time_sheets do |t|
      t.bigint :employee_id
      t.integer :task_id
      t.date :entry_date
      t.time :start_time
      t.time :end_time
      t.time :hours_taken
      t.boolean :billable
      t.text :description

      t.timestamps
    end
  end
end
