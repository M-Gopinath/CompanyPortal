class AddIsTakenToTaskTimer < ActiveRecord::Migration[5.0]
  def change
    add_column :task_timers, :is_taken, :boolean, default: false
  end
end
