class CreateOfficeSalaries < ActiveRecord::Migration[5.0]
  def change
    create_table :office_salaries do |t|
      t.bigint :employee_id
      t.string :salary_year
      t.string :salary_month
      t.date :salary_date
      t.decimal :breakage_money, precision: 10, scale: 2
      t.decimal :balance_money_to_give, precision: 10, scale: 2

      t.timestamps
    end
  end
end
