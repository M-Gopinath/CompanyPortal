class AddAnotherThreeColumnsToEmployeeCtcMonthlies < ActiveRecord::Migration[5.0]
  def change
    add_column :employee_ctc_monthlies, :estimate_medical, :decimal, precision: 10, scale: 2
    add_column :employee_ctc_monthlies, :estimate_mobile, :decimal, precision: 10, scale: 2
    add_column :employee_ctc_monthlies, :estimate_special_allowance, :decimal, precision: 10, scale: 2
  end
end
