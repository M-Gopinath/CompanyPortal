class CreateEmployeeCtcMonthlies < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_ctc_monthlies do |t|
      t.integer :employee_ctc_year_id
      t.date :month_year
      t.bigint :employee_id
      t.decimal :basic_pay, precision: 10, scale: 2
      t.decimal :hra, precision: 10, scale: 2
      t.decimal :house_rent, precision: 10, scale: 2
      t.decimal :tax_deduction, precision: 10, scale: 2
      t.decimal :special_allowance, precision: 10, scale: 2
      t.decimal :telephone_allowance, precision: 10, scale: 2
      t.decimal :medical_allowance, precision: 10, scale: 2
      t.decimal :pf_employeer_contribution, precision: 10, scale: 2
      t.decimal :pf_employee_contribution, precision: 10, scale: 2
      t.decimal :gratuity_employeer_contribution, precision: 10, scale: 2
      t.decimal :professonal_tax, precision: 10, scale: 2
      t.decimal :loss_of_pay, precision: 10, scale: 2
      t.decimal :total_earnings, precision: 10, scale: 2
      t.decimal :total_deduction, precision: 10, scale: 2
      t.decimal :net_salary, precision: 10, scale: 2

      t.timestamps
    end
  end
end
