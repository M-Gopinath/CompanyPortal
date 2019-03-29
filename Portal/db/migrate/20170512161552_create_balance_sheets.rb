class CreateBalanceSheets < ActiveRecord::Migration[5.0]
  def change
    create_table :balance_sheets do |t|
      t.date :month_year
      t.decimal :office_income, precision: 10, scale: 2
      t.decimal :office_expense, precision: 10, scale: 2
      t.decimal :office_net_salary, precision: 10, scale: 2
      t.decimal :office_overall_salary, precision: 10, scale: 2
      t.decimal :diff_net_overall_salary, precision: 10, scale: 2
      t.decimal :office_share, precision: 10, scale: 2
      t.decimal :gopi_share, precision: 10, scale: 2
      t.decimal :saran_share, precision: 10, scale: 2
      t.decimal :office_profit_loss, precision: 10, scale: 2
      t.decimal :gopi_profit_loss, precision: 10, scale: 2
      t.decimal :saran_profit_loss, precision: 10, scale: 2
      t.decimal :amount_received_by_gopi, precision: 10, scale: 2
      t.decimal :amount_received_by_saran, precision: 10, scale: 2
      t.decimal :amount_spent_by_gopi, precision: 10, scale: 2
      t.decimal :amount_spent_by_saran, precision: 10, scale: 2
      t.decimal :balance_money_to_gopi, precision: 10, scale: 2
      t.decimal :balance_money_to_saran, precision: 10, scale: 2
      t.decimal :gopi_total_pay, precision: 10, scale: 2
      t.decimal :saran_total_pay, precision: 10, scale: 2
      t.decimal :final_total_pay_to_gopi, precision: 10, scale: 2
      t.decimal :final_total_pay_to_saran, precision: 10, scale: 2

      t.timestamps
    end
  end
end
