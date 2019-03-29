class EmployeeQualificationDetailsController < ApplicationController
  before_action :set_employee_qualification, only: [:show, :edit, :update]
  def index
    @filterrific = initialize_filterrific(
      Employee.actived_employees,
      params[:filterrific],
      select_options: {
      sorted_by: Employee.options_for_sorted_by
      }
    ) or return
    @employees = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
    p "@@@@@@22"
    p @employees
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @employees.to_csv }
      format.xls { send_data @employees.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Employee Qualification Detail", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end
  def create
    @employee_qualification_detail = EmployeeQualificationDetail.new(employee_qualification_params)
    respond_to do |format|
      if @employee_qualification_detail.save
        @employee = @employee_qualification_detail.employee
        flash[:success] = "Employee Qualification Detail created successfully"
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
      if @employee_qualification_detail.update(employee_qualification_params)
        @employee = @employee_qualification_detail.employee
        flash[:success] = "Employee Qualification Detail updated successfully"
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
    @employee_qualification_detail = EmployeeQualificationDetail.find(params[:id])
    @employee_qualification_detail.destroy
  end

  private

  def set_employee_qualification
    @employee_qualification_detail = EmployeeQualificationDetail.find(params[:id])
  end

  def employee_qualification_params
    params.require(:employee_qualification_detail).permit(:employee_id, :education_degree, :year_of_passing, :percentage, :institution_name, :university_board)
  end

end
