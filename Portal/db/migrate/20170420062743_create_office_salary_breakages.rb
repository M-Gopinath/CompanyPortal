class CreateOfficeSalaryBreakages < ActiveRecord::Migration[5.0]
  def change
    create_table :office_salary_breakages do |t|
      t.bigint :employee_id
      t.string :given_year
      t.string :given_month
      t.date :given_date
      t.decimal :money_given, precision: 10, scale: 2
      t.decimal :money_to_give, precision: 10, scale: 2

      t.timestamps
    end
  end
end
