class BalanceSheet < ApplicationRecord

  def self.get_balancesheet_list(start_year, end_year, start_month, end_month)
    self.where('month_year >= ? && month_year <= ? && month_year >= ? && month_year <= ?', start_year, end_year, start_month, end_month)
  end
end
