class ProjectEmployeeController < ApplicationController
  def index
    @clients = Client.active_clients
  end

  def change_client
    @client = Client.find(params[:client_id])
    @projects = @client.present? ? @client.projects : []
  end

  def project_employees
    @projects = ProjectEmployee.where(project_id: params[:project_id])
    @assigned_users = @projects.map {|p| Employee.find_by(employee_id: p.employee_id) if Employee.all.include?(Employee.find_by(employee_id: p.employee_id))}
    @unassigned_users = @assigned_users.present? ? Employee.actived_employees.map {|e| e unless @assigned_users.include?(e)}.compact : Employee.actived_employees
    @project_id = params[:project_id]
    @client_id = Project.find(params[:project_id]).try(:client_id)
  end

  def assign_employees
    @employees = Employee.where(id: params[:project_employee_unassign])
    @employees.each do |e|
      @project_employee = ProjectEmployee.find_by(employee_id: e.employee_id, project_id: params[:project_id], client_id: params[:client_id])
      @assign_user = current_employee
      @employee = Employee.find_by(employee_id: e.employee_id)
      @project = Project.find_by(id: params[:project_id])
      @client = Client.find_by(id: params[:client_id])
      ProjectMailer.unassign_user(@assign_user, @employee, @project, @client).deliver
      @project_employee.destroy
    end
    @projects = ProjectEmployee.where(project_id: params[:project_id])
    @assigned_users = @projects.map {|p| Employee.find_by(employee_id: p.employee_id) if Employee.all.include?(Employee.find_by(employee_id: p.employee_id))}
    @unassigned_users = @assigned_users.present? ? Employee.actived_employees.map {|e| e unless @assigned_users.include?(e)}.compact : Employee.actived_employees
    @project_id = params[:project_id]
    @client_id = params[:client_id]
  end

  def unassign_employees  
    @employees = Employee.where(id: params[:project_employee_assign])
    @employees.each do |e|
      @project_employee = ProjectEmployee.new
      @project_employee.employee_id = e.employee_id
      @project_employee.project_id = params[:project_id]
      @project_employee.client_id = params[:client_id]
      @project_employee.save
      @assign_user = current_employee
      @employee = Employee.find_by(employee_id: @project_employee.employee_id)
      @project = Project.find_by(id: @project_employee.project_id)
      @client = Client.find_by(id: @project_employee.client_id)
      ProjectMailer.assign_user(@assign_user, @employee, @project, @client).deliver
    end
    @projects = ProjectEmployee.where(project_id: params[:project_id])
    @assigned_users = @projects.map {|p| Employee.find_by(employee_id: p.employee_id) if Employee.all.include?(Employee.find_by(employee_id: p.employee_id))}
    @unassigned_users = @assigned_users.present? ? Employee.actived_employees.map {|e| e unless @assigned_users.include?(e)}.compact : Employee.actived_employees
    @project_id = params[:project_id]
    @client_id = params[:client_id]
  end
end
