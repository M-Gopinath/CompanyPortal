class CreateEmployeeMonthlyWorkReports < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_monthly_work_reports do |t|
      t.bigint :employee_id
      t.float :company_working_days
      t.float :employee_worked_days
      t.float :loss_of_pay
      t.integer :month
      t.integer :year

      t.timestamps
    end
  end
end
