module LeavePermissionsHelper
	def get_remaining_leave_counts(name)
		type_id = LeaveType.find_by_name(name).id
		current_month = Date.today.month
		current_year = Date.today.year
		current_employee.employee_leave_balances.find_by(current_month: current_month, current_year: current_year, leave_type_id: type_id).try(:leave_balance)
	end

	def get_recent_activities
		current_date = Time.now
		last_two_month = Time.now - 2.months
		@recent_activities = current_employee.leave_request_activities.where('created_at >= ? && created_at <= ?',last_two_month,  current_date).order("created_at DESC").paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
	end

	def get_recent_permission_activities
		current_date = Time.now
		last_two_month = Time.now - 2.months
		@recent_activities = current_employee.permission_request_activities.where('created_at >= ? && created_at <= ?',last_two_month,  current_date).order("created_at DESC").paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
	end
	
	def get_leave_types
    LeaveType.where.not(name: t("leave_types.loss_of_pay")).map{|lt| [lt.name, lt.id]}
  end
end
