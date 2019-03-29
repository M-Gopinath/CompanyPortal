class EmployeeMailer < ApplicationMailer
  def send_employee_details(employee)
    @employee = employee
    mail(to: @employee.email, subject: 'Employee Login Details')
  end
end
