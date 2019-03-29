class EmployeePersonalDetail < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  belongs_to :employee
  GENDER = ['Male', 'Femail']
  BLOODGROUP = ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-']
end
