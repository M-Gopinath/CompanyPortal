class Task < ApplicationRecord
	belongs_to :project
	belongs_to :task_priority
	belongs_to :task_status
	belongs_to :task_type
	belongs_to :employee
	has_many :task_attachments, dependent: :destroy
	has_many :task_comments, dependent: :destroy
	has_many :time_sheets
	has_many :task_timers

	accepts_nested_attributes_for :task_attachments, :reject_if => proc { |attributes| attributes['file'].blank? }
	accepts_nested_attributes_for :task_comments, :reject_if => proc { |attributes| attributes['description'].blank? }

	def assign_to
		# employee
	end

	def priority
		self.task_priority.try(:name)
	end

	def status
		self.try(:task_status).try(:name)
	end

	def task_type?
		self.try(:task_type).try(:name)
	end

	def estimated_hours?
		self.estimated_hours.present? ? estimated_hours.strftime("%H:%M") : "None"
	end

	def spent_hours?
		self.actual_hours_taken.present? ? actual_hours_taken.strftime("%H:%M") : "None"
	end

	def create_time
		self.created_at.strftime("%b %d %a %H:%M %p")
	end

	def timer_entry(employee)
		timer = task_timers.where(employee_id: employee.id).last
		if timer.present?
			if timer.start_time.present? && timer.end_time.present?
				true
			elsif timer.start_time.present? && !timer.end_time.present?
				false
			else !timer.end_time.present
				false
			end
		else
			true
		end
	end

	def updated_at?
		self.updated_at.strftime("%Y-%m-%d")
	end

	def due_date?
		self.due_date.strftime("%Y-%m-%d")
	end
end
