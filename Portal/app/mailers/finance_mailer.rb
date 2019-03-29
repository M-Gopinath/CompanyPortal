class FinanceMailer < ApplicationMailer

  def notify_expense(expense)
    @expense = expense
    mail(to: %w(gopi170987@gmail.com saranp111@gmail.com), subject: "Expense Detail")
  end

  def notify_income(income)
    @income = income
    mail(to: %w(gopi170987@gmail.com saranp111@gmail.com), subject: "Income Detail")
  end
end
