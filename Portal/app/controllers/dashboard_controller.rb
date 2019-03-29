class DashboardController < ApplicationController
  def index
  end

  def common	
  end

  def listing
  end

  def active_listing
    @filterrific = initialize_filterrific(
      Project.all,
      params[:filterrific],
      select_options: {
      sorted_by: Project.options_for_sorted_by
      }
    ) or return
    @active_projects = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 5)
  end

  def deactive_listing
  	
  end

  def update_project
    @project = Project.find_by(id: params[:id])
    @project.update(project_params)
    redirect_to dashboard_active_listing_path
  end

  def destroy_project
    @project = Project.find_by(id: params[:id])
    @project.destroy
    redirect_to dashboard_active_listing_path
  end

  def deactive_project
    @project = Project.find_by(id: params[:id])
    @project.update_attributes(is_active: params[:is_active])
    redirect_to dashboard_active_listing_path
  end

  def create_project
    @project = Project.new(project_params)
    @skills = params[:skill_tag].present? ? params[:skill_tag].split("|") : []
    projects_short_name
    @project.save
    projects_skills_create unless @project.errors.present?
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
    params.require(:project).permit(:name, :short_name, :client_id, :description, :is_active)
  end
  
end
