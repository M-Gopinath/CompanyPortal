module EmployeeAddressesHelper
  def all_addresses(employee)
    employee.employee_addresses.reject {|l| l.id.nil?}
  end

  def check_home_address(employee)
    check_address("PERMANENT ADDRESS", employee)
  end

  def check_mail_address(employee)
    check_address("CURRENT ADDRESS", employee)
  end

  def check_work_address(employee)
    check_address("OFFICIAL ADDRESS", employee)
  end

  def check_address(type, employee)
    if employee.employee_addresses.present? && employee.employee_addresses.any? { |ua| ua.employee_address_type == address_type(type) }
      employee.employee_addresses.map { |ua| ua if ua.employee_address_type == address_type(type)}.compact.first
    end
  end

  def address_type(type)
    EmployeeAddressType.find_by_name(type)
  end

  def employee_address_type(type)
    EmployeeAddressType.find_by_name(type).try(:id)
  end

end
