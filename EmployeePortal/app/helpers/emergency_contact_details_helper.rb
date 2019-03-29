module EmergencyContactDetailsHelper
  def check_emp_contact(employee)
    employee.employee_emergency_contact_details.present? ? employee.employee_emergency_contact_details.last : employee.employee_emergency_contact_details.build
  end

  def all_contacts(emp)
    emp.employee_emergency_contact_details.reject {|c| c.id.nil? }
  end
end
