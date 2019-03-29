class CreateLeaveRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :leave_requests do |t|
      t.bigint :employee_id
      t.bigint :approver_id
      t.float :no_of_days
      t.date :from_date
      t.date :to_date
      t.text :reason
      t.integer :leave_permission_status_id
      t.integer :leave_type_id

      t.timestamps
    end
  end
end
