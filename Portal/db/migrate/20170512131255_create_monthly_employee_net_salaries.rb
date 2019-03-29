class CreateMonthlyEmployeeNetSalaries < ActiveRecord::Migration[5.0]
  def change
    create_table :monthly_employee_net_salaries do |t|
      t.decimal :net_salary, precision: 10, scale: 2
      t.date :month_year
      t.decimal :total_earnings, precision: 10, scale: 2
      t.decimal :total_deduction, precision: 10, scale: 2

      t.timestamps
    end
  end
end
