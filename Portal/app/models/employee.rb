class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  require 'csv'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
         # :recoverable, :rememberable, :trackable, :confirmable
  belongs_to :role
  has_one :employee_bank_detail, dependent: :destroy
  has_many :leave_requests, dependent: :destroy
  has_many :leave_request_activities, dependent: :destroy
  has_many :employee_emergency_contact_details, dependent: :destroy
  has_many :employee_languages, dependent: :destroy
  has_many :employee_yearly_leave_balances, dependent: :destroy
  has_many :employee_leave_balances, dependent: :destroy
  has_one :employee_personal_detail
  has_many :employee_addresses, dependent: :destroy
  has_many :employee_loss_of_pays, dependent: :destroy
  has_many :employee_monthly_work_reports, dependent: :destroy
  has_many :permission_requests, dependent: :destroy
  has_many :permission_request_activities, dependent: :destroy
  has_many :employee_qualification_details, dependent: :destroy
  has_many :employee_professional_details, dependent: :destroy
  has_many :employee_education_details, dependent: :destroy
  has_many :employee_employment_details, dependent: :destroy
  has_many :project_employees, dependent: :destroy
  has_many :employee_ctc_years, dependent: :destroy
  has_many :employee_ctc_monthlies, dependent: :destroy
  after_create :user_details
  scope :all_employees, -> {where.not(role_id: [1,2])}
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

  def full_name
    return unless first_name && last_name
    [try(:first_name).camelize, try(:last_name).camelize].compact.join(' ')
  end

  def user_details
    unless self.admin?
      if self.ctc.present?
        basic = ((self.ctc.to_f * 30)/100)
        hra = ((basic.to_f*50)/100)
        pf = 21600
        # pf = ((basic*12)/100)
        gratuity = ((basic.to_f*4.82)/100)
        medical = 4000
        incentive = generate_insentive
        special = (self.ctc - (basic + hra + pf + gratuity + medical + incentive))
        employee_ctc = self.employee_ctc_years.build(basic_pay: basic, hra: hra, pf_employeer_contribution: pf, gratuity_employeer_contribution: gratuity, medical_insurance: medical, special_allowance: special, incentive: incentive)
        employee_ctc.save
      end
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

  def generate_insentive
    case self.role.name
    when "SOFTWARE ENGINEER TRAINEE"
      9000
    when "SOFTWARE ENGINEER"
      18000
    when "SENIOR SOFTWARE ENGINEER"
      21000
    when "TEAM LEAD"
      24000
    when "MANAGER"
      30000
    end
  end

end
