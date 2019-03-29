class EmployeeEmploymentDetail < ApplicationRecord
  mount_uploader :photo_copy, AvatarUploader
  belongs_to :employee
  belongs_to :employee_professional_detail
  belongs_to :employment_certificate
end
