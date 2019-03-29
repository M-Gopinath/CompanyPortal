class EmployeeAddressType < ApplicationRecord
  has_many :employee_addresses, dependent: :destroy
end
