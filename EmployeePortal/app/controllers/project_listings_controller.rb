class ProjectListingsController < ApplicationController
  def active_projects
    @filterrific = initialize_filterrific(
      Project.all.where(is_active: true),
      params[:filterrific],
      select_options: {
      sorted_by: Project.options_for_sorted_by
      }
    ) or return
    @projects = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
    @project = Project.new
    @skills = Skill.all
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @projects.to_csv }
      format.xls { send_data @projects.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Project", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def deactive_projects
    @filterrific = initialize_filterrific(
      Project.all.where.not(is_active: true),
      params[:filterrific],
      select_options: {
      sorted_by: Project.options_for_sorted_by
      }
    ) or return
    @project = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @project.to_csv }
      format.xls { send_data @project.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Project", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def project_list
    @project_list = ProjectEmployee.where(employee_id: current_employee.employee_id).page(params[:page]).paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @project_list.to_csv }
      format.xls { send_data @project_list.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Project", disposition: 'attachment',
        layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
  end

  def new
    @project = Project.new
    @project.projects_skills.build
    @skills = Skill.all
  end

  def project_create
    @project = current_employee.projects.build(project_params)
    respond_to do |format|
      if @project.save
        projects_short_name
        @skills = params[:skill_tag].present? ? params[:skill_tag].split("|") : []
        projects_skills_create
        format.html { redirect_to active_projects_path, notice: 'Project was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def delete_project
    @project = Project.find_by(id: params[:project_id])
    @project.destroy
    redirect_to :back
  end

  def edit
    @project = Project.find_by(id: params[:id])
    @skills = Skill.all
  end

  def project_update
    @project = Project.find_by(id: params[:id])
    @project.update(project_params)
    redirect_to active_projects_path
  end

  def projects_short_name
    name = @project.name
    if name.present?
      len = name.split#scan(/\w+/)
      if len.size > 1
        sn = ""
        len.each_with_index do |word, index|
          sn += index == 0 ? "#{word[0,2]}" : "-#{word[0,2]}"
        end
        @project.short_name = sn
      elsif len.size == 1
        @project.short_name = len[0][0,4]
      end
      @project.save
    end
  end

  def projects_skills_create
    if @skills.count > 0 
      skills = Skill.where("name IN (?)", @skills)
      skills.each do |skill|
        @project.projects_skills.create(skill_id: skill.id)
      end
    end
  end

  def active
    if params[:project_id].present?
      @project = Project.find_by(id: params[:project_id])
      @project.is_active = 'ture'
      @project.save
      redirect_to  deactive_projects_path
    end
  end

  def deactive
    if params[:project_id].present?
      @project = Project.find_by(id: params[:project_id])
      @project.is_active = 'false'
      @project.save
      redirect_to active_projects_path
    end
  end

  def profile_details
  end

  def task_management
    select_client_and_employees
    @client = params[:client_id].present? ? @clients.find_by(id: params[:client_id]) : @clients.first
    @projects = @client.present? ? @client.projects : []
    @project = params[:project_id].present? ? @projects.find_by(id: params[:project_id]) : @projects.first
    assign_project_employees
  end

  def task_create
    select_client_and_employees
    @project = Project.find_by(id: params[:project_id])
    @client = @clients.find_by(id: @project.try(:client_id))
    @projects = @client.present? ? @client.projects : []
    assign_project_employees
    @task = @project.tasks.build(task_params)
    @task.save
    @assign_user = current_employee
    @employee = Employee.find_by(id: params[:task][:employee_id])
    TaskMailer.task_assign(@assign_user, @employee, @project, @task).deliver
  end

  def update
    select_client_and_employees
    get_client_project_task
    assign_project_employees
    @task.update(task_params)
  end

  def update_task
    select_client_and_employees
    get_client_project_task
    assign_project_employees
    status = TaskStatus.find_by(name: "#{params[:status]}").try(:id)
    @task.update_attributes(task_status_id: status)
    timer_entry
  end

  def task_comments_update
    select_client_and_employees
    get_client_project_task
    assign_project_employees
    @task.update(task_params)
  end

  def get_client_project_task
    @task = Task.find_by(id: params[:task_id])
    @project = @task.try(:project)
    @client = @project.try(:client)
    @projects = @client.present? ? @client.projects : []
  end

  def assign_project_employees
    ids = @project.present? ? @project.project_employees.collect(&:employee_id) : []
    @employees = @employees.where("employee_id IN (?)",ids)
  end

  def select_client_and_employees
    if current_employee.admin? || current_employee.manager?
      @clients = Client.active_clients
      @employees = Employee.actived_employees
    else
      assigned_projects = current_employee.assigned_projects
      @clients = Client.active_clients.where("id IN (?)", assigned_projects.collect(&:client_id))
      @employees = Employee.actived_employees.where("employee_id IN (?)", assigned_projects.collect(&:employee_id))
    end
  end

  def task_timesheet_create
    select_client_and_employees
    get_client_project_task
    assign_project_employees
    @time_sheet = TimeSheet.new(time_sheet_params)
    set_start_and_end_time
    @time_sheet.save
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

  def time_diff(start_time, end_time)
    seconds_diff = (start_time - end_time).to_i.abs

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end

  def timer_entry
    if params[:status] == "INPROGRESS"
      @task_timer = @task.task_timers.where(employee_id: current_employee.id).last
      if params[:timer_entry] == "Resume"
        @task_timer = @task.task_timers.create(employee_id: current_employee.id,task_id: @task.id, start_time: Time.zone.now)
      else
        @task_timer.update_attributes(end_time: Time.zone.now)
        @task_timer = TaskTimer.find(@task_timer.id)
        @task_timer.lap_time = @task_timer.lap_time?
        @task_timer.save
      end
    end
  end

  private
    def task_params
      params.require(:task).permit(:project_id, :employee_id, :title, :description, :task_type_id, :task_priority_id, :task_status_id, :start_date, :due_date, :estimated_hours, :actual_hours_taken, :hide_to_client, task_attachments_attributes: [:id, :task_id, :file, :task_comment_id],task_comments_attributes: [:id, :task_id, :employee_id, :description,:client_id,task_attachments_attributes: [:id, :task_id, :file, :task_comment_id]])
    end

    def time_sheet_params
      params.require(:time_sheet).permit(:employee_id, :task_id, :entry_date, :start_time, :end_time, :hours_taken, :description, :billable)
    end

    def project_params
      params.require(:project).permit(:name, :short_name, :client_id, :description, :is_active)
    end
end
