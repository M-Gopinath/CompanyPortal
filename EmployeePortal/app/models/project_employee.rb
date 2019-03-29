class ProjectEmployee < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :project
  belongs_to :client

  def get_project(id)
  	@project = Project.find_by(id: id, is_active: true)
  end

  def get_project_history(id)
  	@project = Project.find_by(id: id, is_active: false)
  end
end
