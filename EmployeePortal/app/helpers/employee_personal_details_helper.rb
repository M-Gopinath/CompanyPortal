module EmployeePersonalDetailsHelper

  def employee_personal_record
    employee_signed_in? && current_employee.employee_personal_detail.present? ? current_employee.employee_personal_detail : current_employee.build_employee_personal_detail 
  end
end
