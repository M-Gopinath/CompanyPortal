module DashboardHelper
  def possible_options
    [["Mr.", "Mr."], ["Mrs.", "Mrs."], ["Ms.", "Ms."]]
  end

  def employee_supervisor(employee)
    emp = Employee.find_by_employee_id(employee.supervisor_id)
    emp.present? ? [[emp.full_name, emp.employee_id]] : []
  end
end
