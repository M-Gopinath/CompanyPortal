class DashboardController < ApplicationController
  def index
    if employee_signed_in? && current_employee.admin?
      redirect_to admin_dashboard_path
    end
  end

  def admin_dashboard
    @employees = Employee.all_employees
  end

  def profile
    
  end
end
