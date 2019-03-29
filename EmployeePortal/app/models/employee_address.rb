class EmployeeAddress < ApplicationRecord
  belongs_to :employee
  belongs_to :employee_address_type
end
