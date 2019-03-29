class ProjectsController < ApplicationController
	def index
		@project = Project.new
		@project.projects_skills.build
		@skills = Skill.all
		@filterrific = initialize_filterrific(
      current_client.projects,
      params[:filterrific],
      select_options: {
      sorted_by: Project.options_for_sorted_by
      }
    ) or return
    @projects = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @projects.to_csv }
      format.xls { send_data @projects.to_csv(col_sep: "\t") }
      format.pdf do
        render pdf: "Policy", disposition: 'attachment',
        # layout: 'layouts/pdf_layout.html.erb',
        :page_size => 'A4',
        :margin => {:top=> 0,:bottom => 0,:left=> 0,:right => 0}
      end
    end
	end

	def remove_project
		@project = Project.find_by(id: params[:project_id])
		@project.destroy
		redirect_to projects_path
	end

	def edit_project
		@project = Project.find_by(id: params[:project_id])
		if @project.update(project_params)
			projects_short_name
			@skills = params[:skill_tag].present? ? params[:skill_tag].split("|") : []
			projects_skills_update
		end
		redirect_to projects_path
	end

	def new
		@project = Project.new
		@project.projects_skills.build
		@skills = Skill.all
	end

	def show
		@project = Project.find_by(id: params[:id])
	end

	def create
		@project = current_client.projects.build(project_params)
		respond_to do |format|
			if @project.save
				projects_short_name
				@skills = params[:skill_tag].present? ? params[:skill_tag].split("|") : []
				projects_skills_create
				format.html { redirect_to :back, notice: 'Project was successfully created.' }
			else
				format.html { render :new }
			end
		end
	end

	def task_create
		@project = current_client.projects.find_by(id: params[:project_id])
    if @project.present?
      @task = @project.tasks.build(task_params)
      if @task.save
      	@employees = Employee.all_non_employees
      	@assign_user = current_client
      	@project = Project.find_by(id: params[:task][:project_id])
      	@current_task = Task.find_by(id: @task.id)
      	TaskMailer.task_assign(@assign_user, @employees, @project, @current_task).deliver
				redirect_to :back
      else
      	p "errors..........................................."
      	p @task.errors.full_messages
				redirect_to :back, notice: @task.errors.full_messages
      end
    end
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

	def projects_skills_update
		if @skills.count > 0 
			skills = Skill.where("name IN (?)", @skills)
			skills.each do |skill|
				if @project.projects_skills.count > 0
					unless @project.projects_skills.find_by(skill_id: skill.id)
						@project.projects_skills.create(skill_id: skill.id)
					end
				else
					@project.projects_skills.create(skill_id: skill.id)
				end
			end
		end
	end

	def projects_list
		@client = current_client
		@projects = current_client.projects
		@project = params[:project_id].present? ? @projects.find_by(id: params[:project_id]) : @projects.first
	end

	def task_update
		@client = current_client
		@projects = current_client.projects
		@project = @projects.find_by(id: params[:project_id])
		@task = @project.tasks.find_by(id: params[:task_id])
		@task.update(task_params)
	end

	def task_update_status
		@client = current_client
		@projects = current_client.projects
		@project = @projects.find_by(id: params[:project_id])
		@task = @project.tasks.find_by(id: params[:task_id])
		status = TaskStatus.find_by(name: "#{params[:status]}").try(:id)
    @task.update_attributes(task_status_id: status)
	end

	def task_comments_update
    @client = current_client
		@projects = current_client.projects
		@project = @projects.find_by(id: params[:project_id])
		@task = @project.tasks.find_by(id: params[:task_id])
		@task.update(task_params)
  end

  def time_sheet
  	params_day = params[:day].present? ? params[:day].to_date : false
  	@select_month_start = params_day.present? ? params_day.beginning_of_month : Date.today.beginning_of_month
  	@select_month_end = params_day.present? ? params_day.end_of_month : Date.today.end_of_month
  	current_day = params_day.present? ? params_day.end_of_month == Date.today.end_of_month : false
  	@select_week = params_day.present? ? params_day.beginning_of_week : Date.today.beginning_of_week
  	@select_day = params_day.present? ? params_day.beginning_of_day : Date.today.beginning_of_day
  	@client = current_client
  	@projects = @client.projects
  	@tasks = Task.joins(:project).where("projects.id IN (?)", @projects.collect(&:id))
  	@tasks = @tasks.where("start_date <= ? && due_date >= ?", @select_day, @select_day)

  end

	private
		def project_params
			params.require(:project).permit(:name, :short_name, :client_id,:description)
		end

		def task_params
			params.require(:task).permit(:project_id, :employee_id, :title, :description, :task_type_id, :task_priority_id, :task_status_id, :start_date, :due_date, :estimated_hours, :actual_hours_taken, :hide_to_client, task_attachments_attributes: [:id, :task_id, :file, :task_comment_id],task_comments_attributes: [:id, :task_id, :employee_id, :description,:client_id,task_attachments_attributes: [:id, :task_id, :file, :task_comment_id]])
		end
end