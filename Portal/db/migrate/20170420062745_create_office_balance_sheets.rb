class CreateOfficeBalanceSheets < ActiveRecord::Migration[5.0]
  def change
    create_table :office_balance_sheets do |t|
      t.string :year
      t.string :month
      t.decimal :office_income, precision: 10, scale: 2
      t.decimal :office_expense, precision: 10, scale: 2
      t.decimal :office_share, precision: 10, scale: 2
      t.decimal :gopinath_share, precision: 10, scale: 2
      t.decimal :saravanan_share, precision: 10, scale: 2

      t.timestamps
    end
  end
end
