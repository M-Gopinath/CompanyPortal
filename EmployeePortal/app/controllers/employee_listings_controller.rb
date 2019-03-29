class EmployeeListingsController < ApplicationController
  def active_listing
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

  def deactive_listing
    @filterrific = initialize_filterrific(
      Employee.deactived_employees,
      params[:filterrific],
      select_options: {
      sorted_by: Employee.options_for_sorted_by
      }
    ) or return
    @deactived_employees = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @deactived_employees.to_csv }
      format.xls { send_data @deactived_employees.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Employee Deactive List", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def deactivate
    @employee = Employee.find_by_employee_id(params[:employee_id])
    @employee.update_attributes(is_active: false)
    redirect_to active_employees_path
  end

  def activate
    @employee = Employee.find_by_employee_id(params[:employee_id])
    @employee.update_attributes(is_active: true)
    redirect_to deactive_employees_path
  end
end
