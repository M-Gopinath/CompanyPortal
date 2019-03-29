class Project < ApplicationRecord
  belongs_to :client
  belongs_to :employee, optional: true
	has_many :projects_skills
	has_many :tasks
  has_many :project_employees
  has_many :office_incomes

  scope :active_projects, -> {where(is_active: true)}
  scope :deactive_projects, -> {where.not(is_active: true)}

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
    num_or_conds = 7
    joins(:client).where(
      terms.map { |term|
        "(LOWER(clients.first_name) LIKE ? OR LOWER(clients.last_name) LIKE ? OR LOWER(clients.email) LIKE ? OR LOWER(clients.full_name) LIKE ? OR LOWER(projects.name) LIKE ? OR LOWER(projects.short_name) LIKE ? OR LOWER(projects.description) LIKE ?)"
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
      order("projects.name #{ direction }")
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
  		csv << ["Project Name", "Project ShortName", "Project Description"]
  		all.each do |al|
  			csv << [al.name, al.short_name, al.description]
  		end
  	end
  end
end
