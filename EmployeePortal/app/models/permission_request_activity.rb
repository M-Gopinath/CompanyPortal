class PermissionRequestActivity < ApplicationRecord
	belongs_to :permission_request
	def get_status(id)
  	@status = LeavePermissionStatus.find_by(id: id)
  	@status.name
  end
end
