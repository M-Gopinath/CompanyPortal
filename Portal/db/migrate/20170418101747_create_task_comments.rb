class CreateTaskComments < ActiveRecord::Migration[5.0]
  def change
    create_table :task_comments do |t|
      t.integer :task_id
      t.bigint :employee_id
      t.text :description

      t.timestamps
    end
  end
end
