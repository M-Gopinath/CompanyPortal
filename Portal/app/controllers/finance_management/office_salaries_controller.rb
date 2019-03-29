class FinanceManagement::OfficeSalariesController < ApplicationController
  def index
    @date = params[:date].present? && (params[:date].to_date != Date.today.beginning_of_month) ? params[:date].to_date : Time.now
    @filterrific = initialize_filterrific(
      Employee.actived_employees.where('created_at <= ?', @date),
      params[:filterrific],
      select_options: {
      sorted_by: Employee.options_for_sorted_by
      }
    ) or return
    @actived_employees = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
    @monthly_ctc = EmployeeCtcMonthly.get_monthly_earnings(@date)
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @actived_employees.to_csv }
      format.xls { send_data @actived_employees.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Employee Active List", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def create
  end

  private

  def salary_params
    params.require(:office_salary).permit(:employee_id, :salary_date, :breakage_money, :balance_money_to_give, :salary)
  end
end
