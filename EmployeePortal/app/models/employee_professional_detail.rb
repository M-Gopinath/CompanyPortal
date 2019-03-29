class EmployeeProfessionalDetail < ApplicationRecord
  belongs_to :employee
  has_one :employee_employment_detail
end
