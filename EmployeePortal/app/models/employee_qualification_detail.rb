class EmployeeQualificationDetail < ApplicationRecord
  belongs_to :employee
  has_one :employee_education_detail
end
