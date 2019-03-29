class AddSalaryToOfficeSalary < ActiveRecord::Migration[5.0]
  def change
    add_column :office_salaries, :salary, :decimal, precision: 10, scale: 2
  end
end
