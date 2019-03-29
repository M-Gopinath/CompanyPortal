class EmployeeCtcMonthly < ApplicationRecord
  belongs_to :employee
  belongs_to :employee_ctc_year
  def self.get_monthly_earnings(date)
    self.where(month_year: date.beginning_of_month)
  end
end