class AddInsentiveToCtc < ActiveRecord::Migration[5.0]
  def change
    add_column :employee_ctc_years, :incentive, :decimal, precision: 10, scale: 2
    add_column :employee_ctc_monthlies, :incentive, :decimal, precision: 10, scale: 2
  end
end
