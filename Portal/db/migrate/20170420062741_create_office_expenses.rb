class CreateOfficeExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :office_expenses do |t|
      t.string :spent_year
      t.string :spent_month
      t.date :spent_date
      t.string :description
      t.integer :transaction_via_id
      t.decimal :money_spent, precision: 10, scale: 2

      t.timestamps
    end
  end
end
