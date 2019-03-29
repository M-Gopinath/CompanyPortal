class CreatePermissionRequestActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :permission_request_activities do |t|
      t.bigint :employee_id
      t.bigint :approver_id
      t.integer :permission_request_id
      t.integer :leave_permission_status_id
      t.text :description

      t.timestamps
    end
  end
end
