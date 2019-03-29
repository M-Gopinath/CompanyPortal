module EmployeeBankDetailsHelper
  def check_emp_bank(employee)
    employee.employee_bank_detail.present? ? employee.employee_bank_detail : EmployeeBankDetail.new
  end

  def check_current_employee
    current_admin.present? ? true : false
  end
end


