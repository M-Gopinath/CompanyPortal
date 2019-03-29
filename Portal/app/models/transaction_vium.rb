class TransactionVium < ApplicationRecord
  has_many :office_incomes
  has_many :office_expenses
end
