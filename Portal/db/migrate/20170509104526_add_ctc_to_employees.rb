class AddCtcToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :ctc, :decimal, precision: 10, scale: 2
  end
end
