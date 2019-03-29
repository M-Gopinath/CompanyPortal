class CreateClientCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :client_companies do |t|
      t.integer :client_id
      t.string :name
      t.string :contact_number
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :zip_code

      t.timestamps
    end
  end
end
