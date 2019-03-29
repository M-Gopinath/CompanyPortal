class EmployeeLanguage < ApplicationRecord
  belongs_to :employee
  belongs_to :speaking_proficiency
  belongs_to :writing_proficiency
end
