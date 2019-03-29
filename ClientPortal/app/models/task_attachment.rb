class TaskAttachment < ApplicationRecord
	mount_uploader :file, FileUploader
	belongs_to :task, optional: true
	belongs_to :task_comment, optional: true
end
