class LeavePermissionsController < ApplicationController
	before_action :leave_request_cal, only: [:apply_leave, :create_apply_leave, :update_apply_leave, :cancel_applied_leave]
  before_action :permission_request_cal, only: [:apply_permission, :cancel_applied_permission]
  before_action :approve_permission_request_cal, only: [:permission_approve]
  before_action :cancel_permission_request_cal, only: [:permission_cancel]
  before_action :reject_permission_request_cal, only: [:permission_reject]
  before_action :cancel_leave_request_cal, only: [:leave_cancel]
  before_action :reject_leave_request_cal, only: [:leave_reject]
 
	def index
		@approve_user = Employee.where(supervisor_id: current_employee.employee_id)
    pending_requests = []
    pending_leave_requests = []
    approved_permissions = []
    approved_leaves = []
    @approve_user.each do |approver|
		  pending_requests << approver.permission_requests.where(leave_permission_status_id: 1).order('created_at DESC') if @approve_user.present?
      pending_leave_requests << approver.leave_requests.where(leave_permission_status_id: 1).order('created_at DESC') if @approve_user.present?
      approved_permissions << approver.permission_requests.where.not(leave_permission_status_id: 1).order('created_at DESC') if @approve_user.present?
      approved_leaves << approver.leave_requests.where.not(leave_permission_status_id: 1).order('created_at DESC') if @approve_user.present?
    end
    @pending_requests = pending_requests.flatten
    @pending_leave_requests = pending_leave_requests.flatten
    @approved_permissions = approved_permissions.flatten
    @approved_leaves = approved_leaves.flatten
    respond_to do |format|
      format.html
      format.js
      if params[:pdf_request] == "permission"
        format.csv { send_data @approved_permissions.to_csv }
        format.xls { send_data @approved_permissions.to_csv(col_sep: "\t") }
      end
      if params[:pdf_request] == "leave"
        format.csv { send_data @approved_leaves.to_csv }
        format.xls { send_data @approved_leaves.to_csv(col_sep: "\t") }
      end
      format.pdf do
        render pdf: "Leave List", 
        disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
	end
	
	def apply_leave
		@apply_leave = current_employee.leave_requests.build
	end

	def create_apply_leave
		@apply_leave = current_employee.leave_requests.build(leave_request_params)
    @approver = current_employee.approver?
    if @apply_leave.save
      @status = LeavePermissionStatus.find_by(name: "PENDING")
			@apply_leave.update_attributes(leave_permission_status_id: @status.id)
			@apply_leave.leave_request_activities.create(employee_id: current_employee.employee_id, leave_permission_status_id: @apply_leave.leave_permission_status_id, description: @apply_leave.reason)
			LeaveMailer.leave_permission_mail(@apply_leave).deliver
			LeaveMailer.leave_permission_to_approver(@apply_leave, @approver).deliver
			@apply_leave = current_employee.leave_requests.build
			respond_to do |format|
				format.html {redirect_to leave_permissions_apply_leave_path}
				format.js
			end
		end
	end

	def cancel_applied_leave
		@leave = params[:id]
		@apply_leave = current_employee.leave_requests.find(@leave)
    @approver = current_employee.approver?
		if @apply_leave.leave_permission_status_id == 1
			@status = LeavePermissionStatus.find_by(name: "CANCEL")
			@apply_leave.update_attributes(leave_permission_status_id: @status.id)
      # Return leave balance counts
      user_leaves = @apply_leave.employee.employee_leave_balances.find_by(current_month: Date.today.month, current_year: Date.today.year, leave_type_id: @apply_leave.leave_type_id)
      balance_count = user_leaves.leave_balance + @apply_leave.no_of_days
      user_leaves.update_attributes(leave_balance: balance_count) if user_leaves.present?

      @apply_leave.leave_request_activities.create(employee_id: current_employee.employee_id, leave_permission_status_id: @apply_leave.leave_permission_status_id, description: params[:description])
      # LeaveMailer.delay.cancel_leave(@apply_leave)
      LeaveMailer.cancel_leave(@apply_leave, @approver).deliver
    end
    @new_apply_leave = current_employee.leave_requests.build
  end

  def leave_balance
  end

  def apply_permission
  	@apply_permission = current_employee.permission_requests.build
  	@limit = @permission_list_calendars.where.not(leave_permission_status_id: 4)
  end

  def create_apply_permission
  	@apply_permission = current_employee.permission_requests.build(permission_request_params)
    @approver = current_employee.approver?
    # p start_time = Time.parse(params[:permission_request][:from_time])
    # p end_time = Time.parse(params[:permission_request][:to_time])
    # @time_diff = time_diff(start_time, end_time)
    # @apply_permission.update_attributes(no_of_hours: @time_diff)
  	if @apply_permission.save
  		@status = LeavePermissionStatus.find_by(name: "PENDING")
  		@apply_permission.update_attributes(leave_permission_status_id: @status.id)
  		@apply_permission.permission_request_activities.create(employee_id: current_employee.employee_id, leave_permission_status_id: @apply_permission.leave_permission_status_id, description: @apply_permission.reason)
  		PermissionMailer.permission_mail(@apply_permission).deliver
  		PermissionMailer.permission_to_approver(@apply_permission, @approver).deliver
  		respond_to do |format|
  			format.html {redirect_to leave_permissions_apply_permission_path}
  			format.js
  		end
  	end
  end

  def cancel_applied_permission
  	@permission = params[:id]
  	@apply_permission = current_employee.permission_requests.find(@permission)
    @status = LeavePermissionStatus.find_by(name: "CANCEL")
    @approver = current_employee.approver?
    if @apply_permission.leave_permission_status_id == 1
      @apply_permission.update_attributes(leave_permission_status_id: @status.id)
      @apply_permission.permission_request_activities.create(employee_id: current_employee.employee_id, leave_permission_status_id: @apply_permission.leave_permission_status_id, description: params[:description])
      @limit = @permission_list_calendars.where.not(leave_permission_status_id: 4)
      PermissionMailer.cancel_permission(@apply_permission, @approver).deliver
  	end
  end

  def approve_permission
  	@permission_request = PermissionRequest.find(params[:permission_id])
  	unless @permission_request.leave_permission_status_id == params[:leave_permission_status_id]
  		@permission_request.update_attributes(leave_permission_status_id: params[:leave_permission_status_id], approver_id: current_employee.employee_id)
  		@permission_request.permission_request_activities.create(employee_id: @permission_request.employee_id, leave_permission_status_id: @permission_request.leave_permission_status_id, description: @permission_request.reason)
      @approver = current_employee.approver?
      PermissionMailer.approved_permission(@permission_request, @approver).deliver if @permission_request.leave_permission_status_id == 2
      PermissionMailer.rejected_permission(@permission_request, @approver).deliver if @permission_request.leave_permission_status_id == 3
    end
    @approve_user = Employee.find_by(supervisor_id: current_employee.employee_id)
    @pending_requests = @approve_user.permission_requests.where(leave_permission_status_id: 1).order('created_at DESC')
    @approved_permissions = @approve_user.permission_requests.where.not(leave_permission_status_id: 1).order('created_at DESC') if @approve_user.present?
    @approved_leaves = @approve_user.leave_requests.where.not(leave_permission_status_id: 1).order('created_at DESC') if @approve_user.present?
  	respond_to do |format|
  		format.html {redirect_to leave_permissions_index_path}
  		format.js
  	end
  end

  def approve_leaves
  	@leave_request = LeaveRequest.find(params[:leave_id])
    @status = LeavePermissionStatus.find_by(name: "CANCEL")
    @approver = current_employee.approver?
  	unless @leave_request.leave_permission_status_id == 2
  		@leave_request.update_attributes(leave_permission_status_id: params[:leave_permission_status_id], approver_id: current_employee.employee_id)
  		@leave_request.leave_request_activities.create(employee_id: @leave_request.employee_id, leave_permission_status_id: @leave_request.leave_permission_status_id, description: @leave_request.reason)
      # Create loss of pay
      user_leaves = @leave_request.employee.employee_leave_balances.find_by(current_month: Date.today.month, current_year: Date.today.year, leave_type_id:  @leave_request.leave_type_id)
      check_lop = @leave_request.no_of_days - user_leaves.leave_balance if user_leaves.present?
      @leave_request.employee.employee_loss_of_pays.create(month: Date.today.month, year: Date.today.year, leave_period: check_lop) if check_lop.present? && check_lop > 0
      LeaveMailer.approved_leave(@leave_request, @approver).deliver
    end
    @approve_user = Employee.find_by(supervisor_id: current_employee.employee_id)
    @pending_requests = @approve_user.leave_requests.where(leave_permission_status_id: 1).order('created_at DESC') if @approve_user.present?
    @approved_permissions = @approve_user.permission_requests.where.not(leave_permission_status_id: 1).order('created_at DESC') if @approve_user.present?
    @approved_leaves = @approve_user.leave_requests.where.not(leave_permission_status_id: 1).order('created_at DESC') if @approve_user.present?
    respond_to do |format|
    	format.html {redirect_to leave_permissions_index_path}
    	format.js
    end
  end

  def reject_leaves
  	@leave_request = LeaveRequest.find(params[:leave_id])
    @approver = current_employee.approver?
  	unless @leave_request.leave_permission_status_id == 3
  		@leave_request.update_attributes(leave_permission_status_id: params[:leave_permission_status_id], approver_id: current_employee.employee_id)
      # Return leave balance counts
      #user_leaves = @leave_request.employee.employee_leave_balances.find_by(current_month: Date.today.month, current_year: Date.today.year, leave_type_id: @leave_request.leave_type_id)
      #balance_count = user_leaves.leave_balance + @leave_request.no_of_days
      #user_leaves.update_attributes(leave_balance: balance_count) if user_leaves.present?

      @leave_request.leave_request_activities.create(employee_id: @leave_request.employee_id, leave_permission_status_id: @leave_request.leave_permission_status_id, description: @leave_request.reason)
      LeaveMailer.rejected_leave(@leave_request, @approver).deliver
    end
    @approve_user = Employee.find_by(supervisor_id: current_employee.employee_id)
    @pending_requests = @approve_user.leave_requests.where(leave_permission_status_id: 1).order('created_at DESC') if @approve_user.present?
    @approved_permissions = @approve_user.permission_requests.where.not(leave_permission_status_id: 1).order('created_at DESC') if @approve_user.present?
    @approved_leaves = @approve_user.leave_requests.where.not(leave_permission_status_id: 1).order('created_at DESC') if @approve_user.present?
    respond_to do |format|
    	format.html {redirect_to leave_permissions_index_path}
    	format.js
    end
  end

  def time_diff(start_time, end_time)
    seconds_diff = (start_time - end_time).to_i.abs

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end

  # admin code
  def leave_approve
    @date = params[:date].present? ? params[:date].to_date : Time.now
    start_year = @date.beginning_of_year
    end_year = @date.end_of_year
    start_month = @date.beginning_of_month
    end_month = @date.end_of_month
    @filterrific = initialize_filterrific(
      LeaveRequest.get_approve_leave_request(start_year, end_year, start_month, end_month),
      params[:filterrific],
      select_options: {
      sorted_by: LeaveRequest.options_for_sorted_by
      }
    ) or return
    @approve_permission_request = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @approve_permission_request.to_csv }
      format.xls { send_data @approve_permission_request.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Permission Approve List", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def leave_cancel
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @cancel_permission_request.to_csv }
      format.xls { send_data @cancel_permission_request.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Permission Cancel List", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def leave_reject
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @reject_leave_request.to_csv }
      format.xls { send_data @reject_leave_request.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Permission Approve List", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def leave_destroy
    @leave = LeaveRequest.find_by(id: params[:leave_id])
    @leave.destroy
    redirect_to :back
  end

  def permission_destroy
    @permission = PermissionRequest.find_by(id: params[:permission_id])
    @permission.destroy
    redirect_to :back
  end

  def permission_approve
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @approve_permission_request.to_csv }
      format.xls { send_data @approve_permission_request.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Permission Approve List", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def permission_cancel
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @cancel_permission_request.to_csv }
      format.xls { send_data @cancel_permission_request.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Permission Cancel List", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def permission_reject
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @reject_permission_request.to_csv }
      format.xls { send_data @reject_permission_request.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Permission Reject List", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

	private

	def leave_request_params
		params.require(:leave_request).permit(:leave_type_id, :from_date, :to_date, :no_of_days, :reason)
	end

	def leave_request_cal
		@date = params[:date].present? ? params[:date].to_date : Time.now
		start_year = @date.beginning_of_year
		end_year = @date.end_of_year
		start_month = @date.beginning_of_month
		end_month = @date.end_of_month
		@leave_list_calendars = current_employee.leave_requests.where('from_date >= ? && from_date <= ? && from_date >= ? && from_date <= ?', start_year, end_year, start_month, end_month).paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
	end

	def permission_request_cal
		@date = params[:date].present? ? params[:date].to_date : Time.now
		start_year = @date.beginning_of_year
		end_year = @date.end_of_year
		start_month = @date.beginning_of_month
		end_month = @date.end_of_month
		@permission_list_calendars = current_employee.permission_requests.where('permission_date >= ? && permission_date <= ? && permission_date >= ? && permission_date <= ?', start_year, end_year, start_month, end_month).order('created_at DESC').paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
	end

  def approve_permission_request_cal
    @date = params[:date].present? ? params[:date].to_date : Time.now
    start_year = @date.beginning_of_year
    end_year = @date.end_of_year
    start_month = @date.beginning_of_month
    end_month = @date.end_of_month
    @filterrific = initialize_filterrific(
      PermissionRequest.get_approve_permission_request(start_year, end_year, start_month, end_month),
      params[:filterrific],
      select_options: {
        sorted_by: PermissionRequest.options_for_sorted_by
      }
      ) or return
    @approve_permission_request = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
  end

  def cancel_permission_request_cal
    @date = params[:date].present? ? params[:date].to_date : Time.now
    start_year = @date.beginning_of_year
    end_year = @date.end_of_year
    start_month = @date.beginning_of_month
    end_month = @date.end_of_month
    @filterrific = initialize_filterrific(
      PermissionRequest.get_cancel_permission_request(start_year, end_year, start_month, end_month),
      params[:filterrific],
      select_options: {
      sorted_by: PermissionRequest.options_for_sorted_by
      }
    ) or return
    @cancel_permission_request = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
  end

  def reject_permission_request_cal
    @date = params[:date].present? ? params[:date].to_date : Time.now
    start_year = @date.beginning_of_year
    end_year = @date.end_of_year
    start_month = @date.beginning_of_month
    end_month = @date.end_of_month
    @filterrific = initialize_filterrific(
      PermissionRequest.get_reject_permission_request(start_year, end_year, start_month, end_month),
      params[:filterrific],
      select_options: {
      sorted_by: PermissionRequest.options_for_sorted_by
      }
    ) or return
    @reject_permission_request = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
  end

  def cancel_leave_request_cal
    @date = params[:date].present? ? params[:date].to_date : Time.now
    start_year = @date.beginning_of_year
    end_year = @date.end_of_year
    start_month = @date.beginning_of_month
    end_month = @date.end_of_month
    @filterrific = initialize_filterrific(
      LeaveRequest.get_cancel_leave_request(start_year, end_year, start_month, end_month),
      params[:filterrific],
      select_options: {
      sorted_by: LeaveRequest.options_for_sorted_by
      }
    ) or return
    @cancel_permission_request = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
  end

  def reject_leave_request_cal
    @date = params[:date].present? ? params[:date].to_date : Time.now
    start_year = @date.beginning_of_year
    end_year = @date.end_of_year
    start_month = @date.beginning_of_month
    end_month = @date.end_of_month
    @filterrific = initialize_filterrific(
      LeaveRequest.get_reject_leave_request(start_year, end_year, start_month, end_month),
      params[:filterrific],
      select_options: {
      sorted_by: LeaveRequest.options_for_sorted_by
      }
    ) or return
    @reject_leave_request = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
  end

	def permission_request_params
		params.require(:permission_request).permit(:employee_id, :permission_date, :from_time, :to_time, :reason, :no_of_hours)
	end
end
