class CreateTaskTimers < ActiveRecord::Migration[5.0]
  def change
    create_table :task_timers do |t|
      t.bigint :employee_id
      t.string :task_id
      t.bigint :lap_time
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
