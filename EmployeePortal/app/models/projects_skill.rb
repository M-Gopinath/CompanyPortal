class ProjectsSkill < ApplicationRecord
	belongs_to :project
	def get_skill_name(id)
		@skill = Skill.find_by(id: id)
		@skill.try(:name)
	end
end
