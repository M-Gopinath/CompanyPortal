class CompanySalarySpent
  @queue = :total_salary_queue
  def self.perform
    today = Date.today.beginning_of_year
    total_salary = MonthlyEmployeeNetSalary.find_by(month_year: Date.today.beginning_of_year)
    ctc_monthlies = EmployeeCtcMonthly.where(month_year: Date.today.beginning_of_year)
    if total_salary.blank? && ctc_monthlies.present?
      earnings = ctc_monthlies.collect(&:total_earnings).compact.sum
      deduction = ctc_monthlies.collect(&:total_deduction).compact.sum
      totla_net = earnings - deduction
      MonthlyEmployeeNetSalary.create(month_year: today, total_earnings: earnings, total_deduction: deduction, net_salary: totla_net)
    end
  end
end