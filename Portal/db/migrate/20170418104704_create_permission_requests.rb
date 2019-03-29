class CreatePermissionRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :permission_requests do |t|
      t.bigint :employee_id
      t.bigint :approver_id
      t.date :permission_date
      t.date :from_time
      t.time :to_date
      t.time :no_of_hours
      t.text :reason
      t.integer :leave_permission_status_id

      t.timestamps
    end
  end
end
