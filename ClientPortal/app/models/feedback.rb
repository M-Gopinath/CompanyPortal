class Feedback < ApplicationRecord
	belongs_to :project
	belongs_to :client

	def get_project_name(id)
		@project = Project.find_by(id: id)
		@project.try(:name)
	end

	def get_client_name(id)
		@client = Client.find_by(id: id)
		@client.try(:name?)
	end

	def get_employee_name(id)
		@employee = Employee.find_by(employee_id: id)
		@employee.try(:name?)
	end

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
        "(LOWER(feedbacks.feedback) LIKE ? OR LOWER(feedbacks.feedback) LIKE ? OR LOWER(feedbacks.feedback) LIKE ? )"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("feedbacks.created_at #{ direction }")
    when /^title_/
      order("feedbacks.feedback #{ direction }")
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
      csv << ["Project Name", "Client Name", "Employee Name", "Feedback"]
      all.each do |al|
        csv << [al.get_project_name(al.project_id), al.get_client_name(al.client_id), al.get_employee_name(al.employee_id), al.feedback]
      end
    end
  end
end