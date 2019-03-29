class ProjectsController < ApplicationController
	def index
		@filterrific = initialize_filterrific(
      Project.all,
      params[:filterrific],
      select_options: {
      sorted_by: Project.options_for_sorted_by
      }
    ) or return
    @projects = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
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

	def new
		@project = Project.new
		@project.projects_skills.build
		@skills = Skill.all
	end

	def show
		@project = Project.find_by(id: params[:id])
	end

	def create
		@project = current_employee.projects.build(project_params)
		respond_to do |format|
			if @project.save
				projects_short_name
				@skills = params[:skill_tag].present? ? params[:skill_tag].split("|") : []
				projects_skills_create
				format.html { redirect_to projects_path, notice: 'Project was successfully created.' }
			else
				format.html { render :new }
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


	private
	def project_params
		params.require(:project).permit(:name, :short_name, :client_id,:description)
	end
end
