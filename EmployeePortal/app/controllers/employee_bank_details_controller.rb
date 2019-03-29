class EmployeeBankDetailsController < ApplicationController
  before_action :set_employee_bank_detail, only: [:show, :edit, :update]
  before_action :set_employee, only: [:new, :edit]

  def index
     @filterrific = initialize_filterrific(
      Employee.actived_employees,
      params[:filterrific],
      select_options: {
      sorted_by: Employee.options_for_sorted_by
      }
    ) or return
    @employees = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @employees.to_csv }
      format.xls { send_data @employees.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Employee Bank Detail", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def new
    @employee_bank_detail = @employee.build_employee_bank_detail
  end

  def create
    @employee_bank_detail = EmployeeBankDetail.new(employee_bank_detail_params)

    respond_to do |format|
      if @employee_bank_detail.save
        format.html { redirect_to :back, notice: 'employee bank detail was successfully created.' }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  def show
  end

  def edit

  end

  def update
    respond_to do |format|
      if @employee_bank_detail.update(employee_bank_detail_params)
        flash[:success] = "Employee Bank details updated successfully"
        format.html { redirect_to :back, notice: 'employee bank detail was successfully updated.' }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  private
    def set_employee_bank_detail
      @employee_bank_detail = EmployeeBankDetail.find(params[:id])
    end

    def employee_bank_detail_params
      params.require(:employee_bank_detail).permit(:employee_id, :account_number, :bank_name, :bank_branch, :ifsc_code)
    end

    def set_employee
      @employee = Employee.find(params[:employee_id])
    end
end
