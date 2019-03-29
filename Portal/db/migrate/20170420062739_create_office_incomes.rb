class CreateOfficeIncomes < ActiveRecord::Migration[5.0]
  def change
    create_table :office_incomes do |t|
      t.integer :client_id
      t.integer :project_id
      t.integer :transaction_via_id
      t.string :money_received_month
      t.string :money_received_year
      t.date :money_received_date
      t.decimal :money_received, precision: 10, scale: 2

      t.timestamps
    end
  end
end
