class AddNewFieldsTimeSheet < ActiveRecord::Migration[5.0]
  def change
  	add_column :time_sheets, :approver_id, :bigint
  	add_column :time_sheets, :time_sheet_status_id, :bigint
  end
end
