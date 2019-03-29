class CreateEmployeeEducationDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_education_details do |t|
      t.bigint :employee_id
      t.integer :employee_qualification_detail_id
      t.integer :education_certificate_id
      t.string :certificate_id
      t.string :photo_copy

      t.timestamps
    end
  end
end
