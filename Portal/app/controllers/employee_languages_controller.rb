class EmployeeLanguagesController < ApplicationController
  before_action :set_employee_language, only: [:show, :edit, :update]

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
        render pdf: "Employee Language", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def new
    @employee_language = @employee.employee_languages.build
  end

  def create
    @employee_language = EmployeeLanguage.new(employee_language_params)
    respond_to do |format|
      if @employee_language.save
        flash[:success] = "Employee Language created successfully"
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
      if @employee_language.update(employee_language_params)
        flash[:success] = "Employee Language updated successfully"
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
    @employee_contact_detail = EmployeeLanguage.find(params[:id])
    @employee_contact_detail.destroy
  end

  private

  def set_employee_language
    @employee_language = EmployeeLanguage.find(params[:id])
  end

  def employee_language_params
    params.require(:employee_language).permit(:employee_id, :language, :speaking_proficiency_id, :writing_proficiency_id)
  end

end
