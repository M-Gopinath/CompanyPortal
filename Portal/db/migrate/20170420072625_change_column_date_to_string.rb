class ChangeColumnDateToString < ActiveRecord::Migration[5.0]
  def change
    change_column :employee_qualification_details, :year_of_passing, :string
  end
end
