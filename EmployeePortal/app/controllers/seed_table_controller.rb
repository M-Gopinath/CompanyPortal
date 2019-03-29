class SeedTableController < ApplicationController

	def role
		@roles = Role.all
	end

	def create_role
		@role = Role.create(role_params)
		redirect_to seed_table_role_path
	end

	def employee
		@employees = Employee.all
	end

	def create_employee
		@employee = Employee.create(employee_params)
		redirect_to seed_table_employee_path
	end

	def skill
		@skills = Skill.all
	end

	def create_skill
		@skill = Skill.create(skill_params)
		redirect_to seed_table_skill_path
	end

	def employee_address_type
		@employee_address_types = EmployeeAddressType.all
	end

	def create_employee_address_type
		@employee_address_type = EmployeeAddressType.create(employee_address_type_params)
		redirect_to seed_table_employee_address_type_path
	end

	def education_certificate
		@education_certificates = EducationCertificate.all
	end

	def create_education_certificate
		@employee_address_type = EducationCertificate.create(education_certificate_params)
		redirect_to seed_table_education_certificate_path
	end

	def employment_certificate
		@employment_certificates = EmploymentCertificate.all
	end

	def create_employment_certificate
		@employment_certificate = EmploymentCertificate.create(employment_certificate_params)
		redirect_to seed_table_employment_certificate_path
	end

	def employee_agreement_type
		@employee_agreement_types = EmployeeAgreementType.all
	end

	def create_employee_agreement_type
		@employee_agreement_type = EmployeeAgreementType.create(employee_agreement_types_params)
		redirect_to seed_table_employee_agreement_type_path
	end

	def client_company
		@client_companyies = ClientCompany.all
	end

	def create_client_company
		@client_company = ClientCompany.create(client_company_params)
		redirect_to seed_table_client_company_path
	end

	def share_holder
		@share_holders = ShareHolder.all
	end

	def create_share_holder
		@share_holder = ShareHolder.create(share_holder_params)
		redirect_to seed_table_share_holder_path
	end

	def transaction_vium
		@transaction_viums = TransactionVium.all
	end

	def create_transaction_vium
		@transaction_vium = TransactionVium.create(transaction_vium_params)
		redirect_to seed_table_transaction_vium_path
	end

	def leave_type
		@leave_types = LeaveType.all
	end

	def create_leave_type
		@leave_type = LeaveType.create(leave_type_params)
		redirect_to seed_table_leave_type_path
	end

	def leave_permission_status
		@leave_permission_statuses = LeavePermissionStatus.all
	end

	def create_leave_permission_status
		@leave_permission_status = LeavePermissionStatus.create(leave_permission_status_params)
		redirect_to seed_table_leave_permission_status_path
	end

	def meeting_event_notification
		@meeting_event_notifications = MeetingEventNotification.all
	end

	def create_meeting_event_notification
		@meeting_event_notification = MeetingEventNotification.create(meeting_event_notification_params)
		redirect_to seed_table_meeting_event_notification_path
	end

	def meeting_event_repeat
		@meeting_event_repeats = MeetingEventRepeat.all
	end

	def create_meeting_event_repeat
		@meeting_event_repeat = MeetingEventRepeat.create(meeting_event_repeat_params)
		redirect_to seed_table_meeting_event_repeat_path
	end

	def privacy_policy
		@privacy_policies = PrivacyPolicy.all
	end

	def create_privacy_policy
		@privacy_policy = PrivacyPolicy.create(privacy_policy_params)
		redirect_to seed_table_privacy_policy_path
	end

	def speaking_proficiency
		@speaking_proficiencies = SpeakingProficiency.all
	end

	def create_speaking_proficiency
		@speaking_proficiency = SpeakingProficiency.create(speaking_proficiency_params)
		redirect_to seed_table_speaking_proficiency_path
	end

	def writing_proficiency
		@writing_proficiencies = WritingProficiency.all
	end

	def create_writing_proficiency
		@speaking_proficiency = WritingProficiency.create(writing_proficiency_params)
		redirect_to seed_table_writing_proficiency_path
	end

	def project
		@projects = Project.all
	end

	def create_project
		@project = Project.create(project_params)
		redirect_to seed_table_project_path
	end

	def socialnetwork
		@socialnetworks = SocialNetwork.all
	end

	def create_socialnetwork
		@socialnetwork = SocialNetwork.create(socialnetwork_params)
		redirect_to seed_table_socialnetwork_path
	end

	def task_type
		@task_types = TaskType.all
	end

	def create_task_type
		@task_type = TaskType.create(task_type_params)
		redirect_to seed_table_task_type_path
	end

	def task_priority
		@task_priorities = TaskPriority.all
	end

	def create_task_priority
		@task_priority = TaskPriority.create(task_priority_params)
		redirect_to seed_table_task_priority_path
	end

	def task_status
		@task_statuses = TaskStatus.all
	end

	def create_task_status
		@task_status = TaskStatus.create(task_status_params)
		redirect_to seed_table_task_status_path
	end

	def time_sheet_status
		@time_sheet_statuses = TimeSheetStatus.all
	end

	def create_time_sheet_status
		@time_sheet_status = TimeSheetStatus.create(time_sheet_status_params)
		redirect_to seed_table_time_sheet_status_path
	end

	def yearly_holiday_calendar
		@yearly_holiday_calendars = YearlyHolidayCalendar.all
	end

	def create_yearly_holiday_calendar
		@yearly_holiday_calendar = YearlyHolidayCalendar.create(yearly_holiday_calendar_params)
		redirect_to seed_table_yearly_holiday_calendar_path
	end

	private

	def role_params
		params.require(:role).permit( :name, :short_name, :grade)
	end

	def employee_params
		params.require(:employee).permit(:title, :first_name, :last_name, :full_name, :dob, :role_id, :supervisor_id,  :email, :first_password, :password, :password_confirmation, :is_active)
	end

	def skill_params
		params.require(:skill).permit( :name, :short_name)
	end

	def employee_address_type_params
		params.require(:employee_address_type).permit( :name, :short_name)
	end

	def education_certificate_params
		params.require(:education_certificate).permit( :name, :short_name)
	end

	def employment_certificate_params
		params.require(:employment_certificate).permit( :name, :short_name)
	end

	def employee_agreement_types_params
		params.require(:employee_agreement_type).permit( :name, :short_name)
	end

	def client_company_params
		params.require(:client_company).permit( :client_id, :name, :contact_number, :address, :city, :state, :country, :zip_code)
	end

	def share_holder_params
		params.require(:share_holder).permit( :percentage, :name)
	end

	def transaction_vium_params
		params.require(:transaction_vium).permit( :percentage, :name)
	end

	def leave_type_params
		params.require(:leave_type).permit( :short_name, :name)
	end

	def leave_permission_status_params
		params.require(:leave_permission_status).permit( :short_name, :name)
	end

	def meeting_event_notification_params
		params.require(:meeting_event_notification).permit( :short_name, :name)
	end

	def meeting_event_repeat_params
		params.require(:meeting_event_repeat).permit( :short_name, :name)
	end

	def privacy_policy_params
		params.require(:privacy_policy).permit( :topic, :description)
	end

	def speaking_proficiency_params
		params.require(:speaking_proficiency).permit( :name, :short_name)
	end

	def writing_proficiency_params
		params.require(:writing_proficiency).permit( :name, :short_name)
	end

	def project_params
		params.require(:project).permit( :name, :short_name)
	end

	def socialnetwork_params
		params.require(:socialnetwork).permit( :network_name, :network_short_name)
	end

	def task_type_params
		params.require(:task_type).permit( :name)
	end

	def task_priority_params
		params.require(:task_priority).permit( :name)
	end

	def task_status_params
		params.require(:task_status).permit( :name)
	end

	def time_sheet_status_params
		params.require(:time_sheet_status).permit( :name, :short_name)
	end

	def yearly_holiday_calendar_params
		params.require(:yearly_holiday_calendar).permit( :holiday_date, :description)
	end
end
