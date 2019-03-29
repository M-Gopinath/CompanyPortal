class LeaveRequestActivity < ApplicationRecord
	belongs_to :leave_request
	belongs_to :employee
	def get_status(id)
  	@status = LeavePermissionStatus.find_by(id: id)
  	@status.name
  end
end
