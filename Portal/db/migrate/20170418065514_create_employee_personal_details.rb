class CreateEmployeePersonalDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_personal_details do |t|
      t.bigint :employee_id
      t.string :contact_number_1
      t.string :contact_number_2
      t.string :personal_email
      t.string :gender
      t.string :blood_group
      t.string :avatar
      t.text :identity_mark_1
      t.text :identity_mark_2
      t.string :pan_number
      t.string :adhaar_card_number
      t.string :driving_license_number
      t.string :voter_id
      t.string :passport_number
      t.date :passport_expiry_date
      t.string :passport_registration_place

      t.timestamps
    end
  end
end
