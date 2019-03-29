class ProjectMailer < ApplicationMailer
	def assign_user(assign_user, employee, project, client)
		@assign_user = assign_user 
		@employee = employee
		@project = project
		@client = client
		mail(to: @employee.email, subject: "Project Assign")
	end

	def unassign_user(assign_user, employee, project, client)
		@assign_user = assign_user 
		@employee = employee
		@project = project
		@client = client
		mail(to: @employee.email, subject: "Project Unassign")
	end
end
