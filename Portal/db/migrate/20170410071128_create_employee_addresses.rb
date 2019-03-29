class CreateEmployeeAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_addresses do |t|
      t.bigint :employee_id
      t.integer :employee_address_type_id
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :zipcode

      t.timestamps
    end
  end
end
