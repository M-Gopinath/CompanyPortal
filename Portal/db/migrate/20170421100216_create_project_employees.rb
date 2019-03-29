class CreateProjectEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :project_employees do |t|
      t.integer :project_id
      t.integer :client_id
      t.bigint :employee_id

      t.timestamps
    end
  end
end
