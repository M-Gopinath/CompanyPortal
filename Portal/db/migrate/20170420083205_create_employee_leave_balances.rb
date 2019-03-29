class CreateEmployeeLeaveBalances < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_leave_balances do |t|
      t.bigint :employee_id
      t.integer :leave_type_id
      t.decimal :leave_balance, precision: 10, scale: 2
      t.integer :current_month
      t.integer :current_year

      t.timestamps
    end
  end
end
