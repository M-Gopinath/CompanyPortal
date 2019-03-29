class TimeSheetMailer < ApplicationMailer
	def approve_cancel(assign_user, employee, status)
		@assign_user = assign_user 
		@employee = employee
		@status = status
		mail(to: @assign_user.email, subject: "Project Unassign")
	end
end
