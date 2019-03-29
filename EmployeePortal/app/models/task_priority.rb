class TaskPriority < ApplicationRecord
	has_one :task

	def self.high?
		TaskPriority.find_by(name: "High")
	end

	def self.medium?
		TaskPriority.find_by(name: "Medium")
	end

	def self.low?
		TaskPriority.find_by(name: "Low")
	end
end
