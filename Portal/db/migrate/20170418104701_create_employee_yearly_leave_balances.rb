class CreateEmployeeYearlyLeaveBalances < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_yearly_leave_balances do |t|
      t.bigint :employee_id
      t.integer :year
      t.integer :leave_type_id
      t.float :leave_balance

      t.timestamps
    end
  end
end
