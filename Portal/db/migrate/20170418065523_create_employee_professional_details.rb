class CreateEmployeeProfessionalDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_professional_details do |t|
      t.bigint :employee_id
      t.string :employment_name
      t.date :from_date
      t.date :to_date
      t.string :designation

      t.timestamps
    end
  end
end
