class Project < ApplicationRecord
  require 'csv'
  
	belongs_to :client
	has_many :projects_skills, dependent: :destroy
	has_many :tasks, dependent: :destroy
	has_many :feedbacks, dependent: :destroy

	accepts_nested_attributes_for :projects_skills

	filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :search_query,
      :sorted_by,
    ]
  )

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    terms = query.to_s.downcase.split(/\s+/)
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    num_or_conds = 3
    where(
      terms.map { |term|
        "(LOWER(projects.name) LIKE ? OR LOWER(projects.description) LIKE ? OR LOWER(projects.id) LIKE ? )"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("projects.created_at #{ direction }")
    when /^title_/
      order("projects.description #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  def self.options_for_sorted_by
  	[
  		['Email (ZA)', 'email_desc'],
  		['Email (AZ)', 'email_asc'],
  		['Created date (newest first)', 'created_at_desc'],
  		['Created date (oldest first)', 'created_at_asc']
  	]
  end
  def self.to_csv(options = {})
  	CSV.generate(options) do |csv|
  		csv << ["Project Name", "Project Description"]
  		all.each do |al|
  			csv << [al.name, al.description]
  		end
  	end
  end

  def assigned_employees
    # Employee.joins(:project_employees).where("project_employees.project_id = ?", self.id)
    pe = ProjectEmployee.where(project_id: self.id)
    return Employee.where("employee_id IN (?)", pe.collect(&:employee_id).uniq.compact)
  end

  def project_skill_name?
    result = ""
    ps = self.projects_skills
    ids = ps.collect(&:skill_id)
    skills = Skill.where("id IN (?)", ids)
    skills.each.with_index(1) do |skill,index|
      result += skills.count == index ? "#{skill.name}" : "#{skill.name}|"
    end
    return result
  end

end
