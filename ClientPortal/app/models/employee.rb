class Employee < ApplicationRecord
  require 'csv'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable
  belongs_to :role
  has_one :employee_bank_detail, dependent: :destroy
  has_many :employee_emergency_contact_details, dependent: :destroy
  has_many :employee_languages, dependent: :destroy
  has_many :employee_addresses, dependent: :destroy
  has_one :employee_personal_detail
  has_many :leave_requests, dependent: :destroy
  has_many :leave_request_activities, dependent: :destroy
  has_many :employee_yearly_leave_balances, dependent: :destroy
  has_many :employee_leave_balances, dependent: :destroy
  has_many :employee_loss_of_pays, dependent: :destroy
  has_many :employee_monthly_work_reports, dependent: :destroy
  has_many :permission_requests, dependent: :destroy
  has_many :permission_request_activities, dependent: :destroy
  has_many :employee_qualification_details, dependent: :destroy
  has_many :employee_professional_details, dependent: :destroy
  has_many :employee_education_details, dependent: :destroy
  has_many :employee_employment_details, dependent: :destroy
  has_many :project_employees, dependent: :destroy
  has_many :time_sheets
  has_many :task_timers
  before_save :set_email
  after_create :user_details
  scope :all_employees, -> {where.not(role_id: [1,2])}
  scope :all_non_employees, -> {where(role_id: [1,2,3,4])}
  scope :actived_employees, -> {where.not(role_id: [1,2]).where(is_active: true)}
  scope :deactived_employees, -> {where.not(role_id: [1,2]).where(is_active: false)}

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
      order("employees.created_at #{ direction }")
    when /^title_/
      order("employees.email #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["Employee Id", "First Name", "Last Name", "Email"]
      all.each do |employee|
        csv << [employee.employee_id, employee.first_name, employee.last_name, employee.email]
      end
    end
  end

   def leave_balance(type_id)
    current_year = Date.today.year
    self.employee_yearly_leave_balances.find_by(year: current_year, leave_type_id: type_id).try(:leave_balance)
  end


  def admin?
    self.role.name == "ADMIN"
  end


  def manager?
    self.role.name == "MANAGER"
  end

  def team_lead?
    self.role.name == "TEAM LEAD"
  end

  def software_engineers?
    senior_sofware_engineer? || software_engineer? || software_engineer_trainee?
  end

  def senior_sofware_engineer?
    self.role.name == 'SENIOR SOFTWARE ENGINEER'
  end

  def software_engineer?
    self.role.name == 'SOFTWARE ENGINEER'
  end

  def software_engineer_trainee?
    self.role.name == 'SOFTWARE ENGINEER TRAINEE'
  end



  def set_email
    unless self.admin?
      if self.new_record?
        self.email = "#{self.email}xxxxx"
        emp_id = Employee.last.employee_id + 1
        self.employee_id = emp_id
        self.full_name = [try(:first_name), try(:last_name)].compact.join(' ').titleize
      end
    end
  end

  def full_name
    return unless first_name && last_name
    [try(:first_name).camelize, try(:last_name).camelize].compact.join(' ')
  end

  def user_details
    unless self.admin?
      EmployeeMailer.send_employee_details(self).deliver_now!
    end
  end 

  def self.options_for_sorted_by
    [
      ['Email (ZA)', 'email_desc'],
      ['Email (AZ)', 'email_asc'],
      ['Created date (newest first)', 'created_at_desc'],
      ['Created date (oldest first)', 'created_at_asc']
     ]
  end

  def name?
    "#{self.first_name} #{self.last_name}"
  end

  def task_timers_is_not_taken(task,day)
    timers = task_timers.where(task_id: task.id).where("start_time >= ? && start_time <= ?", day.to_time.beginning_of_day,day.to_time.end_of_day).where(is_taken: false)
  end

  def total_task_timers(timers)
    total_hours(timers)
  end

  def spend_task_select_day_hours(task,day)
    timers = task_timers.where(task_id: task.try(:id)).where("start_time >= ? && start_time <= ?", day.to_time.beginning_of_day,day.to_time.end_of_day).where(is_taken: false)
    task_timer_cal(timers)
  end

  def spend_task_hours(task)
    timers = task_timers.where(task_id: task.id)
    task_timer_cal(timers)
  end

  def task_timer_cal(timers)
    total_time = total_hours(timers)
    hours_format(total_time)
  end

  def hours_format(total_time)
    if total_time.present?
      hours = total_time / 3600
      total_time -= hours * 3600

      minutes = total_time / 60
      total_time -= minutes * 60

      seconds = total_time

      "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
    else
      "00:00:00"
    end
  end

  def total_hours(timers)
    total_time = 0
    timers.each do |time|
      if time.start_time.present? && time.end_time.present?
        total_time += (time.start_time - time.end_time).to_i.abs
      end
    end
    return total_time
  end

  def task_timers_select(day)
    task_timers.where("start_time >= ? && start_time <= ?", day.to_time.beginning_of_day,day.to_time.end_of_day)
  end

  def time_sheets_select(day)
    time_sheets.where("start_time >= ? && start_time <= ?", day.to_time.beginning_of_day,day.to_time.end_of_day)
  end

  def assigned_projects
    ProjectEmployee.where(employee_id: employee_id)
  end

end
