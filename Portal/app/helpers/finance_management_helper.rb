module FinanceManagementHelper
  def holding_income(income, name)
    income.transaction_via.name == name ? income.money_received : ""
  end

  def get_income(office_incomes, name)
    record = office_incomes.joins(:transaction_via).where('transaction_via.name = ?', name)
    record.collect(&:money_received).sum
  end

  def get_all_income(office_incomes)
    office_incomes.collect(&:money_received).sum
  end

  def get_client_income(c, office_incomes)
    record = office_incomes.joins(:client).where('clients.id = ?', c.id)
    record.collect(&:money_received).sum
  end

  def get_project_details(income)
    income.new_record? ? [] : Project.all.map {|p| [p.name, p.id]}
  end

  def current_month_ctc(ae, date)
    ae.employee_ctc_monthlies.where(month_year: date.beginning_of_month).last
  end

  def employee_total_deduction(m, e, d)
    total = m.try(:pf_employee_contribution).to_f + m.try(:pf_employeer_contribution).to_f + m.try(:professonal_tax).to_f + m.try(:tax_deduction).to_f + m.try(:loss_of_pay).to_f + m.try(:gratuity_employeer_contribution).to_f + check_medical_insurance(e, d)
    total.to_s.include?('.5') ? total : total.to_i
  end

  def check_medical_insurance(e, d)
    e.created_at.month == d.month ? 4000 : 0
  end

  def over_all_monthly_deduction(date)
    employee = Employee.actived_employees
    total = 0
    employee.each do |ae|
      monthly_ctc = current_month_ctc(ae, date)
      total += employee_total_deduction(monthly_ctc, ae, date)
    end
    total.to_s.include?('.5') ? total : total.to_i
  end

  def over_all_monthly_earnings
    employees = Employee.actived_employees
    total = (employees.collect(&:ctc).compact.sum)/12
    total.to_s.include?('.5') ? total : total.to_i
  end

  def over_all_monthly_net_pay(date)
    total = over_all_monthly_earnings + over_all_monthly_deduction(date)
    total.to_s.include?('.5') ? total : total.to_i
  end

  def check_current_month_pf(start_date, bs, index)
    (start_date + index.months).to_date == bs.month_year
  end

  def check_next_month_pf(start_date, bs, index)
    (start_date.next_year + index.months).to_date == bs.month_year
  end

end
