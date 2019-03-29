class AddExtraFieldsToEmployeeCtcMonthly < ActiveRecord::Migration[5.0]
  def change
    add_column :employee_ctc_monthlies, :lop_basic, :decimal, precision: 10, scale: 2
    add_column :employee_ctc_monthlies, :lop_hra, :decimal, precision: 10, scale: 2
    add_column :employee_ctc_monthlies, :lop_special_allowance, :decimal, precision: 10, scale: 2
  end
end
