class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.bigint :project_task_id
      t.integer :project_id
      t.bigint :employee_id
      t.text :title
      t.text :description
      t.integer :task_type_id
      t.integer :task_priority_id
      t.integer :task_status_id
      t.date :start_date
      t.date :due_date
      t.time :estimated_hours
      t.time :actual_hours_taken
      t.boolean :hide_to_client

      t.timestamps
    end
  end
end
