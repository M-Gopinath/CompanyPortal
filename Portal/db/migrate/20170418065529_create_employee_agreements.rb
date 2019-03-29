class CreateEmployeeAgreements < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_agreements do |t|
      t.bigint :employee_id
      t.integer :employee_agreement_type_id
      t.string :photo_copy

      t.timestamps
    end
  end
end
