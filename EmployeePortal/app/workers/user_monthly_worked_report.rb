class UserMonthlyWorkedReport
  @queue = :user_report
  def self.perform
    begin
      current_month = Date.today.month
      current_year = Date.today.year
      to = Date.today - 1.day
      from = to - 1.month
      business_days = count_business_days(from, to)
      users = Employee.actived_employees
      users.each do |u|
        worked_days = u.leave_requests.where('from_date >= ? && to_date <= ?', from, to)
        lop = u.employee_loss_of_pays.find_by(month: current_month, year: current_year)
        lop_count = lop.present? ? lop.leave_period : 0
        emp_worked = business_days - lop_count
        p u.employee_monthly_work_reports.create(company_working_days: business_days, employee_worked_days: emp_worked, loss_of_pay: lop_count, month: current_month, year: current_year)
        p "Monthly worked report Saved"
      end
    rescue Exception => e
      p "monthly worked Error #{e}"
    end
  end

  def self.count_business_days(from, to)
    business_days = 0
    while to >= from
      holiday = YearlyHolidayCalendar.find_by(holiday_date: from)
      business_days = business_days + 1 unless from.sunday? || holiday.present?
      from += 1.day
    end
    business_days
  end
end