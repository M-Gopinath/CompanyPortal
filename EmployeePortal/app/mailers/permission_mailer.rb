class PermissionMailer < ApplicationMailer

  def permission_mail(permission)
    @employee = permission.employee
    @permission = permission
    mail(to: @employee.email, subject: "Permission Request")
  end

  def permission_to_approver(permission, approver)
    @approver = approver
    @employee = permission.employee
    @permission = permission
    mail(to: @approver.email, subject: "New Permission Request")
  end

  def cancel_permission(permission, approver)
    @employee = permission.employee
    @permission = permission
    @approver = approver
    mail(to: ["#{@employee.email}, #{@approver.email}"], subject: "Cancel Permission Request")
  end

  def approved_permission(permission, approver)
    @employee = permission.employee
    @permission = permission
    @approver = approver
    mail(to: @employee.email, subject: "Approver Permission Request")
  end

  def rejected_permission(permission, approver)
    @employee = permission.employee
    @permission = permission
    @approver = approver
    mail(to: @employee.email, subject: "Reject Permission Request")
  end
end
