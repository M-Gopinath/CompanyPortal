class TaskMailer < ApplicationMailer
	def task_assign(assign_user, employee, project, task)
		@assign_user = assign_user 
		@employees = employee
		@project = project
		@task = task
		mail(to: employee.map(&:email).uniq, subject: "Task Assign")
	end
end
