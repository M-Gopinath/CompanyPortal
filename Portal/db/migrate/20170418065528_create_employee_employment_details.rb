class CreateEmployeeEmploymentDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_employment_details do |t|
      t.bigint :employee_id
      t.integer :employee_professional_detail_id
      t.integer :employment_certificate_id
      t.string :photo_copy

      t.timestamps
    end
  end
end
