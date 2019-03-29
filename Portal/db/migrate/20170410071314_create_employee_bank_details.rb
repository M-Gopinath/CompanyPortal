class CreateEmployeeBankDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_bank_details do |t|
      t.bigint :employee_id
      t.string :account_number
      t.string :bank_name
      t.string :bank_branch
      t.string :ifsc_code

      t.timestamps
    end
  end
end
