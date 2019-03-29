class TimeTrackersController < ApplicationController

	def index
    @employees = Employee.where(supervisor_id: current_employee.employee_id)
    @time_sheets = TimeSheet.joins(:employee).where("time_sheets.employee_id IN (?)", @employees.collect(&:id))
    @approved_time_sheets = @time_sheets.approved?
    @cancelled_time_sheets = @time_sheets.cancelled?
    @undefined_time_sheets = @time_sheets.undefined?.paginate(page: params[:page], per_page: 5)
    respond_to do |format|
      format.html
      format.js
      if params[:status] == "undefined"
        @data = @undefined_time_sheets
      elsif params[:status] == "unapproved"
        @data = @approved_time_sheets
      elsif params[:status] == "approved"
        @data = @cancelled_time_sheets
      end
      format.csv { send_data @data.to_csv }
      format.xls { send_data @data.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "client_listings",disposition: 'attachment'
      end
    end
	end
	
	def time_sheet
		params_day = params[:day].present? ? params[:day].to_date : false
  	@select_month_start = params_day.present? ? params_day.beginning_of_month : Date.today.beginning_of_month
  	@select_month_end = params_day.present? ? params_day.end_of_month : Date.today.end_of_month
  	current_day = params_day.present? ? params_day.end_of_month == Date.today.end_of_month : false
  	@select_week = params_day.present? ? params_day.beginning_of_week : Date.today.beginning_of_week
  	@select_day = params_day.present? ? params_day.beginning_of_day : Date.today.beginning_of_day
    @project_employees = ProjectEmployee.where(employee_id: current_employee.employee_id)
    ids = @project_employees.collect(&:project_id)
    @projects = Project.where("id IN (?)", ids)
    @tasks = Task.where("project_id IN (?)",@projects.collect(&:id))

	end

	def apply_leave
	end

  def apply_permission
  end

  def check_task
    @task = Task.find_by(id: params[:task_id])
    unless @task.present?
      @task = params[:task_id] if params[:task_id] == "Other"
    end
    @project_employees = ProjectEmployee.where(employee_id: current_employee.employee_id)
    ids = @project_employees.collect(&:project_id)
    @projects = Project.where("id IN (?)", ids)
    @tasks = Task.where("project_id IN (?)",@projects.collect(&:id))
    @day = params[:day]
  end

  def task_timesheet_create
    @time_sheet = TimeSheet.new(time_sheet_params)
    @time_sheet.employee_id = current_employee.id
    set_start_and_end_time
    @time_sheet.save
    @time_sheet.errors
  end

  def set_start_and_end_time
    if params[:time_sheet][:start_time] != nil && params[:time_sheet][:end_time] != nil && params[:time_sheet][:task_id] == "Other"
      @time_sheet.start_time = Time.parse("#{@time_sheet.entry_date} #{params[:time_sheet][:start_time]}")
      @time_sheet.end_time = Time.parse("#{@time_sheet.entry_date} #{params[:time_sheet][:end_time]}")
      @time_sheet.hours_taken = (@time_sheet.start_time - @time_sheet.end_time).to_i.abs
    end
    if params[:time_sheet][:task_id] != "Other"
      @time_tracks = current_employee.task_timers_is_not_taken(@time_sheet.task,@time_sheet.entry_date)
      @time_sheet.start_time = @time_tracks.try(:first).try(:start_time)
      @time_sheet.end_time = @time_tracks.try(:last).try(:end_time)
      @time_sheet.hours_taken = current_employee.total_task_timers(@time_tracks)
      @time_tracks.update_all(is_taken: true)
    end
  end

  def time_sheet_approved
    @employees = Employee.where(supervisor_id: current_employee.employee_id)
    @time_sheets = TimeSheet.joins(:employee).where("time_sheets.employee_id IN (?)", @employees.collect(&:id))
    @undefined_time_sheets = @time_sheets.undefined?
    @time_sheet = @undefined_time_sheets.find_by(id: params[:id])
    @time_sheet.update_attributes(time_sheet_status_id: TimeSheetStatus.find_by(name: params[:status]).try(:id))
    p "============================"
    p @time_sheet.errors.full_messages
    @assign_user = Employee.find_by(supervisor_id: current_employee.employee_id)
    @employee = current_employee
    @status = TimeSheetStatus.find_by(name: params[:status])
    TimeSheetMailer.approve_cancel(@assign_user, @employee, @status).deliver
    redirect_to time_trackers_index_path
  end

  private

  def time_sheet_params
    params.require(:time_sheet).permit(:employee_id, :task_id, :entry_date, :start_time, :end_time, :hours_taken, :description, :billable)
  end

end
