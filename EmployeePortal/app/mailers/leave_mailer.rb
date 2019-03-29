class LeaveMailer < ApplicationMailer

	
	def leave_permission_to_approver(leave, approver)
    @approver = approver
    @leave = leave
    mail(to: @approver.email, subject: "New Leave Request")
  end

  def leave_permission_mail(leave)
    @employee = leave.employee
    @leave = leave
    mail(to: @employee.email, subject: "Leave Request")
  end

  def cancel_leave(leave, approver)
  	@approver = approver
    @employee = leave.employee
    @leave = leave
    mail(to: ["#{@employee.email}, #{@approver.email}"], subject: "Cancel Leave Request")
  end

  def approved_leave(leave, approver)
  	@approver = approver
    @employee = leave.employee
    @leave = leave
    mail(to: @employee.email, subject: "Approve Leave Request")
  end

  def rejected_leave(leave, approver)
  	@approver = approver
    @employee = leave.employee
    @leave = leave
    mail(to: @employee.email, subject: "Reject Leave Request")
  end

end
