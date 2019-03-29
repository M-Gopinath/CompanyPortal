class EarningsController < ApplicationController
  def payslip
    @date = params[:date].present? ? params[:date].to_date : Time.now
    # start_year = @date.beginning_of_year
    # end_year = @date.end_of_year
    # start_month = @date.beginning_of_month
    # end_month = @date.end_of_month
    # @office_incomes = OfficeIncome.includes(:client).get_income_list(start_year, end_year, start_month, end_month).order('office_incomes.created_at DESC')
    @filterrific = initialize_filterrific(
      Employee.actived_employees,
      params[:filterrific],
      select_options: {
      sorted_by: Employee.options_for_sorted_by
      }
    ) or return
    @actived_employees = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html
      format.js
    end
  end
  def generate_payslip
    @employee = Employee.find(params[:employee_id])
    respond_to do |format|
      format.pdf do
        render pdf: "Payslip", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def my_definition
    @employee = Employee.find(params[:id])
    @ctc_yearly = @employee.employee_ctc_year
    @ctc_monthly = @employee.employee_ctc_monthlies.where(month_year: Date.today.beginning_of_month).last
  end

  def pay_computation
    @date = params[:date].present? ? params[:date].to_date : Time.now
    @next_year = params[:next_year].present? ? params[:next_year].to_date : @date.next_year

    start_year = @date.beginning_of_year
    end_year = @date.next_year.beginning_of_year
    start_month = start_year + 3.months #@date.beginning_of_month
    end_month = end_year + 2.months
    @employee_monthly_ctc = current_employee.employee_ctc_monthlies.where('month_year >= ? && month_year <= ?', start_month, end_month.to_date)
    @previous_month = @employee_monthly_ctc.where('month_year < ?', Date.today.beginning_of_month)
    @next_month = @employee_monthly_ctc.where('month_year >= ?', Date.today.beginning_of_month)
  end

  def update_monthly
    @employee = Employee.find(params[:employee_id])
    @ctc_monthly = @employee.employee_ctc_monthlies.where(month_year: params[:month]).last
    @ctc_yearly = @employee.employee_ctc_year
    houser_rent = params[:house_rent].present? ? params[:house_rent] : 0
    telephone = params[:telephone].present? ? params[:telephone] : 0
    medical = params[:medical].present? ? params[:medical] : 0
    special = (@ctc_yearly.special_allowance/12) - (params[:medical].to_i + params[:telephone].to_i)
    @ctc_monthly.update_attributes(medical_allowance: medical, telephone_allowance: telephone, house_rent: houser_rent, special_allowance: special)
    redirect_to earnings_my_definition_path(id: @employee.id)
  end

  def employee_payslip
    @date = params[:date].present? ? params[:date].to_date : Time.now
    @employee = current_employee
    @monthly_ctc = @employee.employee_ctc_monthlies.where(month_year: @date.beginning_of_month).last
    @work_days = @employee.employee_monthly_work_reports.where(month: @date.month, year: @date.year).last
   respond_to do |format|
      format.html
      format.js
      format.pdf do
        render pdf: "Payslip", disposition: 'inline',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end
end
