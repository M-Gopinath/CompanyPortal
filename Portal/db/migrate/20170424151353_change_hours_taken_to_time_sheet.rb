class ChangeHoursTakenToTimeSheet < ActiveRecord::Migration[5.0]
  def change
  	change_column :time_sheets, :hours_taken, :bigint
  end
end
