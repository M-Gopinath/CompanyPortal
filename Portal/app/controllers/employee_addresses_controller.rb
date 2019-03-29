class EmployeeAddressesController < ApplicationController
  before_action :set_employee_address, only: [:show, :edit, :update]

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
        render pdf: "Employee Address", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def new
    @employee_address = @employee.employee_addresses.build
  end

  def create
    @employee_address = EmployeeAddress.new(employee_address_params)
    respond_to do |format|
      if @employee_address.save
        flash[:success] = "Employee Address created successfully"
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
      if @employee_address.update(employee_address_params)
        flash[:success] = "Employee Address updated successfully"
        format.html {redirect_to admin_dashboard_path}
        format.js
      else
        flash[:success] = "Something went wrong. Check your data"
        format.html {redirect_to admin_dashboard_path}
        p @employee_address.errors
        format.js
      end
    end
  end

  private

  def set_employee_address
    @employee_address = EmployeeAddress.find(params[:id])
  end

  def employee_address_params
    params.require(:employee_address).permit(:employee_id, :employee_address_type_id, :address, :city, :state, :country, :zipcode)
  end

end
