class EmployeeLanguage < ApplicationRecord
  belongs_to :employee
  belongs_to :speaking_proficiency
  belongs_to :writing_proficiency

  def writing_status?
  	writing_proficiency.present? ? try(:writing_proficiency).try(:name) : "-"
  end
end
