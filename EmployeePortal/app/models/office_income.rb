class OfficeIncome < ApplicationRecord
  belongs_to :transaction_via, class_name: 'TransactionVium', foreign_key: 'transaction_via_id'

  def self.get_income_list(start_year, end_year, start_month, end_month)
    self.where('money_received_date >= ? && money_received_date <= ? && money_received_date >= ? && money_received_date <= ?', start_year, end_year, start_month, end_month)
  end

end
