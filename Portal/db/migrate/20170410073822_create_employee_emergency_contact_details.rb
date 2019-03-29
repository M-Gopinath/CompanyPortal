class CreateEmployeeEmergencyContactDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_emergency_contact_details do |t|
      t.bigint :employee_id
      t.string :contact_person_name
      t.string :relationship
      t.boolean :primary
      t.string :contact_number

      t.timestamps
    end
  end
end
