class CreateLeavePermissionStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :leave_permission_statuses do |t|
      t.string :name
      t.string :short_name

      t.timestamps
    end
  end
end
