class RenameToDateToPermissionRequest < ActiveRecord::Migration[5.0]
  def change
  	rename_column :permission_requests, :to_date, :to_time
  end
end
