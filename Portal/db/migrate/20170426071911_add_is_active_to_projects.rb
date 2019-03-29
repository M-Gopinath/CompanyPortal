class AddIsActiveToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :is_active, :boolean
    add_column :projects, :employee_id, :integer
  end
end
