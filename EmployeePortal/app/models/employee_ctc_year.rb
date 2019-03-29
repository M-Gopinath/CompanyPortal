class EmployeeCtcYear < ApplicationRecord
  belongs_to :employee
  has_many :employee_ctc_monthlies, dependent: :destroy
  after_save :create_monthly_report

  def create_monthly_report
    current_date = Date.today
    end_date = current_date.month > 3 ? Date.today.next_year.beginning_of_year + 2.months : Date.today.beginning_of_year + 2.months
    month_count = ((end_date.month+end_date.year*12) - (current_date.month+current_date.year*12))
    (3..14).each do |monthly|
      month_year = Date.today.beginning_of_year + monthly.months
      # if month_year.beginning_of_month >= Date.today.beginning_of_month
        employee_id = self.employee_id
        basic_pay = (self.basic_pay.to_f / 12)
        hra = (self.hra.to_f/12)
        pf_employeer = 1800.00
        gratuity = self.gratuity_employeer_contribution.to_f/12
        medical = 1250.00
        special = special_allowance.to_f/12
        incentive = self.incentive.to_f/12 
        if month_year >= Date.today.beginning_of_month
          ctc_monthly = self.employee_ctc_monthlies.build(month_year: month_year, employee_id: employee_id, basic_pay: basic_pay, hra: hra, pf_employeer_contribution: pf_employeer, gratuity_employeer_contribution: gratuity, medical_allowance: 0, special_allowance: special, pf_employee_contribution: pf_employeer, professonal_tax: 183, house_rent: 0, telephone_allowance: 0, incentive: incentive, estimate_medical: 0, estimate_mobile: 0, estimate_special_allowance: special)
          ctc_monthly.save
        else
          ctc_monthly = self.employee_ctc_monthlies.build(month_year: month_year, employee_id: employee_id)
          ctc_monthly.save
        end
      # end
    end
  end
end
