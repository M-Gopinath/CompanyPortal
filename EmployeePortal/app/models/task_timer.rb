class TaskTimer < ApplicationRecord
	belongs_to :task


	def lap_time?
		(start_time - end_time).to_i.abs
	end
end
