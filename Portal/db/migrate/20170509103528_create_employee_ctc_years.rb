class CreateEmployeeCtcYears < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_ctc_years do |t|
      t.bigint :employee_id
      t.decimal :basic_pay, precision: 10, scale: 2
      t.decimal :hra, precision: 10, scale: 2
      t.decimal :pf_employeer_contribution, precision: 10, scale: 2
      t.decimal :gratuity_employeer_contribution, precision: 10, scale: 2
      t.decimal :medical_insurance, precision: 10, scale: 2
      t.decimal :special_allowance, precision: 10, scale: 2

      t.timestamps
    end
  end
end
