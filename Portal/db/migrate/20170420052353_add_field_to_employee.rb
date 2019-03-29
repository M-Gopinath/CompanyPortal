class AddFieldToEmployee < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :current_month, :integer
    add_column :employees, :current_year, :integer
  end
end
