class CreateTimeSheetStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :time_sheet_statuses do |t|
      t.string :name
      t.string :short_name

      t.timestamps
    end
  end
end
