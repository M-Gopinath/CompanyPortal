class LeaveRequest < ApplicationRecord
  belongs_to :employee
  belongs_to :leave_type
  has_many :leave_request_activities
  def get_status(id)
    @status = LeavePermissionStatus.find_by(id: id)
    @status.name
  end

  def get_emloyee_first_name(id)
    @employee = Employee.find_by(id: id)
    @employee.first_name
  end

  def get_emloyee_last_name(id)
    @employee = Employee.find_by(id: id)
    @employee.last_name
  end

  def self.get_requests(start_year, end_year, start_month, end_month)
    self.joins(:employee).where('from_date >= ? && from_date <= ? && from_date >= ? && from_date <= ?', start_year, end_year, start_month, end_month)
  end

  def self.get_approve_leave_request(start_year, end_year, start_month, end_month)
    ans = get_requests(start_year, end_year, start_month, end_month)
    ans.where(leave_permission_status_id: 2)
  end

  def self.get_reject_leave_request(start_year, end_year, start_month, end_month)
    ans = get_requests(start_year, end_year, start_month, end_month)
    ans.where(leave_permission_status_id: 3)
  end

  def self.get_cancel_leave_request(start_year, end_year, start_month, end_month)
    ans = get_requests(start_year, end_year, start_month, end_month)
    ans.where(leave_permission_status_id: 4)
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
    joins(:employee).where(
      terms.map { |term|
        "(LOWER(employees.first_name) LIKE ? OR LOWER(employees.last_name) LIKE ? OR LOWER(employees.email) LIKE ? )"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("leave_requests.created_at #{ direction }")
    when /^email/
      joins(:employee).order("employees.email #{ direction }")
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
      csv << ["Employee Id", "First Name", "Last Name", "Email"]
      all.each do |al|
        csv << [al.employee_id, al.get_emloyee_first_name(al.employee_id), al.get_emloyee_last_name(al.employee_id), al.get_status(al.leave_permission_status_id)]
      end
    end
  end
end
