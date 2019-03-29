class EmployeeEducationDetail < ApplicationRecord
	mount_uploader :photo_copy, AvatarUploader
	belongs_to :employee
  belongs_to :employee_qualification_detail
  belongs_to :education_certificate
end
