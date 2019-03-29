class ChangeFieldsFromPermissionRequest < ActiveRecord::Migration[5.0]
  def change
  	change_column :permission_requests, :from_time, :time
  end
end
