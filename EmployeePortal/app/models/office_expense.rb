class OfficeExpense < ApplicationRecord
  belongs_to :transaction_via, class_name: 'TransactionVium', foreign_key: 'transaction_via_id'

  def self.get_expense_list(start_year, end_year, start_month, end_month)
    self.where('spent_date >= ? && spent_date <= ? && spent_date >= ? && spent_date <= ?', start_year, end_year, start_month, end_month)
  end

end
