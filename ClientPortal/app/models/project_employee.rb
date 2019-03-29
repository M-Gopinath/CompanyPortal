class ProjectEmployee < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :project
  belongs_to :client
  
	def name?
		Employee.find_by(employee_id: employee_id).try(:name?)
	end

	def employee_id?
		Employee.find_by(employee_id: employee_id).try(:employee_id)
	end

end
