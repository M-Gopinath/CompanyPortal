class EmployeeEmploymentDetailsController < ApplicationController
  before_action :set_employee_employment_detail, only: [:show, :edit, :update, :destroy]
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
        render pdf: "Employee Employment Detail", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end
  def create
    @employee_employment_detail = EmployeeEmploymentDetail.new(employee_education_detail_params)
    respond_to do |format|
      if @employee_employment_detail.save
        @employee = @employee_employment_detail.employee
        flash[:success] = "Employee Employment details created successfully"
        format.html {redirect_to admin_dashboard_path}
        format.js
      else
        flash[:success] = "Something went wrong. Check your data"
        format.html {redirect_to admin_dashboard_path}
        format.js
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @employee_employment_detail.update(employee_education_detail_params)
        @employee = @employee_employment_detail.employee
        flash[:success] = "Employee Employment details updated successfully"
        format.html {redirect_to admin_dashboard_path}
        format.js
      else
        flash[:success] = "Something went wrong. Check your data"
        format.html {redirect_to admin_dashboard_path}
        format.js
      end
    end
  end

  def destroy
    @employee = Employee.find(params[:employee_id])
    @employee_employment_detail = EmployeeEmploymentDetail.find(params[:id])
    @employee_employment_detail.destroy
  end

  private

  def set_employee_employment_detail
    @employee_employment_detail = EmployeeEmploymentDetail.find(params[:id])
  end

  def employee_education_detail_params
    params.require(:employee_employment_detail).permit(:employee_id, :employee_professional_detail_id, :employment_certificate_id, :photo_copy)
  end
end
