class TaskStatus < ApplicationRecord
	has_one :task
	def self.new?
		TaskStatus.find_by(name: "NEW")
	end
end
