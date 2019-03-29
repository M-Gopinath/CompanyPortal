class CreateTaskEmployeeTimers < ActiveRecord::Migration[5.0]
  def change
    create_table :task_employee_timers do |t|
      t.bigint :employee_id
      t.string :task_id
      t.bigint :timer_duration

      t.timestamps
    end
  end
end
