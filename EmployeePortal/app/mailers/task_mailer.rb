class TaskMailer < ApplicationMailer
	def task_assign(assign_user, employee, project, task)
		@assign_user = assign_user 
		@employee = employee
		@project = project
		@task = task
		mail(to: @employee.email, subject: "Task Assign")
	end
end
