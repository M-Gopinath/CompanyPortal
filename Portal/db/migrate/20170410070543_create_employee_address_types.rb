class CreateEmployeeAddressTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_address_types do |t|
      t.string :name
      t.string :short_name

      t.timestamps
    end
  end
end
