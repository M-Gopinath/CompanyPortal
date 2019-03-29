class GenerateMonthlyTax
  @queue = :generate_tax
  def self.perform
    @employees = Employee.actived_employees
    @employees.each do |e|
      begin
        current_month_ctc = e.employee_ctc_monthlies.where(month_year: Date.today.beginning_of_month).last
        year_ctc = e.employee_ctc_year
        # unless current_month_ctc.tax_deduction.present?
        # LOP
        current_month = Date.today.month
        current_year = Date.today.year
        to = Date.today - 1.day
        from = (to - 1.month)
        total_days = (to - from).to_i
        lop = e.employee_monthly_work_reports.find_by(month: current_month, year: current_year)
        lop_count = lop.present? ? lop.loss_of_pay : 0
        one_day_salary = (e.ctc.to_f/12)/total_days
        total_lop = one_day_salary * lop_count
        lop_basic = (current_month_ctc.basic_pay - (total_lop*30).to_f/100)
        lop_hra = (current_month_ctc.hra - (total_lop*50).to_f/100)
        lop_special = (current_month_ctc.special_allowance - (total_lop*20).to_f/100)
        # Tax
        non_tax = (4000 + 250000 + year_ctc.pf_employeer_contribution + year_ctc.gratuity_employeer_contribution).to_f/12
        monthly_non_tax = non_tax + current_month_ctc.pf_employee_contribution + current_month_ctc.professonal_tax + current_month_ctc.house_rent + current_month_ctc.telephone_allowance + current_month_ctc.medical_allowance + total_lop
        total_non_tax = non_tax + monthly_non_tax
        # Total Earnings
        total_earnings = lop_basic + lop_hra + current_month_ctc.medical_allowance + current_month_ctc.telephone_allowance + lop_special
        # Deduction
        if e.ctc < 250000
          deduction = current_month_ctc.pf_employee_contribution + current_month_ctc.professonal_tax
        else
          deduction = current_month_ctc.pf_employee_contribution + current_month_ctc.professonal_tax + get_tax_deduction(total_non_tax, e)
        end

        # net salary
        net = total_earnings - deduction
        # Update
        current_month_ctc.update_attributes(tax_deduction: get_tax_deduction(total_non_tax, e), total_earnings: total_earnings, total_deduction: deduction, net_salary: net, lop_basic: lop_basic, lop_hra: lop_hra, lop_special_allowance: lop_special, loss_of_pay: total_lop)
        # end
      rescue Exception => e
        p "Tax page Error #{e}"
      end
    end
  end

  def self.get_tax_deduction(total_non_tax, employee)
    emp_ctc = employee.ctc
    if emp_ctc > 250000 && emp_ctc <= 500000
      (total_non_tax * 10).to_f/100
    elsif emp_ctc > 500000 && emp_ctc <= 1000000
      (total_non_tax * 20).to_f/100
    elsif emp_ctc > 1000000
      (total_non_tax * 30).to_f/100
    else
      0
    end
  end
end