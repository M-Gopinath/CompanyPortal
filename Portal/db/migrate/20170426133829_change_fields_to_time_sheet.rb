class ChangeFieldsToTimeSheet < ActiveRecord::Migration[5.0]
  def change
  	change_column :time_sheets, :start_time, :datetime
  	change_column :time_sheets, :end_time, :datetime
  end
end
