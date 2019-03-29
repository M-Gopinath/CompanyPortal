class TaskComment < ApplicationRecord
	belongs_to :task
	has_many :task_attachments, dependent: :destroy
	accepts_nested_attributes_for :task_attachments, :reject_if => proc { |attributes| attributes['file'].blank? }
end
