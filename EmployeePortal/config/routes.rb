Rails.application.routes.draw do
  
  get 'earnings/payslip'
  get 'earnings/my_definition'
  get 'earnings/pay_computation'
  post 'earnings/update_monthly'
  get 'earnings/employee_payslip'

  get 'assign_employee', to: 'project_employee#index', as: :assign_employees

  get 'yearly_holiday_calendar/index'

  get 'meeting_calendar/index'
  get '/month/:date', to: 'meeting_calendar#show_month'

  get 'project_listings/profile_details'

  get 'employees/active', to: "employee_listings#active_listing", as: :active_employees
  get 'employees/deactive', to: "employee_listings#deactive_listing", as: :deactive_employees
  get '/deactivate', to: "employee_listings#deactivate", as: :deactivate_employee
  get '/activate', to: "employee_listings#activate", as: :activate_employee

  #client
  get 'clients/active', to: "client_listings#active_clients", as: :active_clients
  get 'clients/deactive', to: "client_listings#deactive_clients", as: :deactive_clients
  get 'clients/client_create', to: "client_listings#client_create", as: :client_create
  put 'clients/:id/update_is_active', to: "client_listings#update_is_active", as: :update_active_clients
  get 'clients/:id/edit', to: "client_listings#edit", as: :edit_clients
  get 'clients/:id', to: "client_listings#show", as: :show_clients
  put 'clients/:id/update', to: "client_listings#update", as: :update_clients
  delete 'clients/:id/delete', to: "client_listings#delete", as: :delete_clients
  post 'clients/create', to: "client_listings#create", as: :create_client
  
  #client companies
  get 'all_clients/companies', to: "client_company_details#index", as: :client_company_details
  get 'clients/:id/company', to: "client_company_details#show", as: :show_clients_company
  post 'clients/:id/update_address', to: "client_company_details#update_same_address", as: :client_update_same_address
  post 'clients/:id/update_company', to: "client_company_details#client_update_companies", as: :client_update_companies
  get 'clients/:id/edit_company', to: "client_company_details#edit", as: :client_edit_companies
  delete 'clients/:id/delete_company', to: "client_company_details#delete", as: :client_delete_company

  #client social network
  get 'social_network', to: "client_social_networks#index", as: :client_social_networks

  #project_listings
  get 'projects/active', to: "project_listings#active_projects", as: :active_projects
  get 'projects/deactive', to: "project_listings#deactive_projects", as: :deactive_projects
  get 'active', to: "project_listings#active", as: :active
  post 'project_create', to: "project_listings#project_create", as: :project_create
  put 'project_update/:id', to: "project_listings#project_update", as: :project_update
  get 'deactive', to: "project_listings#deactive", as: :deactive
  delete 'delete_project', to: "project_listings#delete_project", as: :delete_project
  #projects
  get 'project_listings/task_management'
  resources :project_listings

  # time_trackers
  get 'time_trackers/index'
  get 'time_trackers/time_sheet'
  get 'check_task' => "time_trackers#check_task", as: :check_task
  post 'task/time_sheet' => "time_trackers#task_timesheet_create", as: :timesheet_entry_create
  put 'time_sheet_approved/:id' => 'time_trackers#time_sheet_approved', as: :time_sheet_approved_cancelled
  # leave permission
  get 'leave_permissions/apply_leave'
  get 'leave_permissions/apply_permission'
  get 'leave_permissions/index'
  post 'leave_permissions/create_apply_leave'
  get 'leave_permissions/cancel_applied_leave'
  post 'leave_permissions/create_apply_permission'
  get 'leave_permissions/cancel_applied_permission'
  get 'leave_permissions/approve_leaves'
  get 'leave_permissions/reject_leaves'
  get 'leave_permissions/approve_permission'
  get 'leave_permissions/leave_approve'
  get 'leave_permissions/leave_reject'
  get 'leave_permissions/leave_cancel'
  get 'leave_permissions/permission_approve'
  get 'leave_permissions/permission_cancel'
  get 'leave_permissions/permission_reject'
  delete 'leave_permissions/leave_destroy'
  delete 'leave_permissions/permission_destroy'
  
  post "projects/task_create/:project_id" => "project_listings#task_create",as: :employee_task_create
  put 'projects/task/:task_id/update' => 'project_listings#update_task', as: :update_task
  put 'task_update/:task_id' => 'project_listings#update', as: :task_update
  put 'task_update/:task_id/comments' => 'project_listings#task_comments_update', as: :task_comments_update
  post 'task/:task_id/timesheet_create' => 'project_listings#task_timesheet_create', as: :task_timesheet_create
  get 'project_list' => 'project_listings#project_list', as: :project_list

  get 'dashboard/index'
  get 'dashboard/active_listing'
  get 'dashboard/deactive_listing'
  root 'dashboard#index'
  get 'dashboard', to: 'dashboard#admin_dashboard', as: :admin_dashboard
  devise_for :employees, :controllers => { :registrations => 'registrations'}

  devise_scope :employee do
    get 'check_employee', to: "registrations#check_employee", as: :check_employee
    delete 'destroy_employee/:id', to: "registrations#destroy_employee", as: :destroy_employee
    get 'registrations/assign_supervisor'
    authenticated :employee do
      root 'dashboard#index', as: :authenticated_root
    end

    unauthenticated do
      root 'sessions#new', as: :unauthenticated_root
    end
    
  end
  resources :employee_bank_details
  resources :employee_emergency_contact_details, path: "employees/emergency_contacts"
  resources :employee_languages, path: "employees/languages"
  resources :employee_addresses, path: "employees/addresses"
  resources :employee_agreements, path: "employees/agreements"
  resources :employee_education_details, path: "employees/education_details"
  resources :employee_professional_details, path: "employees/professional_details"
  resources :employee_personal_details, path: "employees/personal_details"
  resources :employee_qualification_details, path: "employees/qualifications"
  resources :employee_employment_details, path: "employees/employment_detail"
  resources :yearly_holiday_calendar
  get 'privacy_policies/new_index'
  put 'privacy_policies/update_policy'
  resources :privacy_policies

  # Seed table
  get 'seed_table/role'
  post 'seed_table/create_role'
  get 'seed_table/employee'
  post 'seed_table/create_employee'
  post 'seed_table/create_skill'
  get 'seed_table/skill'
  get 'seed_table/employee_address_type'
  post 'seed_table/create_employee_address_type'
  get 'seed_table/education_certificate'
  post 'seed_table/create_education_certificate'
  get 'seed_table/employment_certificate'
  post 'seed_table/create_employment_certificate'
  get 'seed_table/employee_agreement_type'
  post 'seed_table/create_employee_agreement_type'
  get 'seed_table/client_company'
  post 'seed_table/create_client_company'
  get 'seed_table/share_holder'
  post 'seed_table/create_share_holder'
  get 'seed_table/transaction_vium'
  post 'seed_table/create_transaction_vium'
  get 'seed_table/leave_type'
  post 'seed_table/create_leave_type'
  get 'seed_table/leave_permission_status'
  post 'seed_table/create_leave_permission_status'
  get 'seed_table/meeting_event_notification'
  post 'seed_table/create_meeting_event_notification'
  get 'seed_table/meeting_event_repeat'
  post 'seed_table/create_meeting_event_repeat'
  get 'seed_table/privacy_policy'
  post 'seed_table/create_privacy_policy'
  get 'seed_table/speaking_proficiency'
  post 'seed_table/create_speaking_proficiency'
  get 'seed_table/writing_proficiency'
  post 'seed_table/create_writing_proficiency'
  get 'seed_table/project'
  post 'seed_table/create_project'
  get 'seed_table/socialnetwork'
  post 'seed_table/create_socialnetwork'
  get 'seed_table/task_type'
  post 'seed_table/create_task_type'
  get 'seed_table/task_priority'
  post 'seed_table/create_task_priority'
  get 'seed_table/task_status'
  post 'seed_table/create_task_status'
  get 'seed_table/time_sheet_status'
  post 'seed_table/create_time_sheet_status'
  get 'seed_table/yearly_holiday_calendar'
  post 'seed_table/create_yearly_holiday_calendar'

  # Agreements
  get 'employee_agreements/bond_letter'
  get 'employee_agreements/experience_letter'
  get 'employee_agreements/relieving_letter'
  get 'employee_agreements/resignation_letter'
  get 'employee_agreements/resignation_letter'
  get 'employee_agreements/joining_letter'

  # Employees detail
  get '/profile', to: "dashboard#profile", as: :personal_details

  # for Assign users
  get '/change_client', to: "project_employee#change_client", as: :change_client
  get '/project_employees', to: "project_employee#project_employees", as: :project_employees
  post '/assign_employees',  to: "project_employee#assign_employees", as: :assigned_employees
  post '/unassign_employees',  to: "project_employee#unassign_employees", as: :unassign_employees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/payslip', to: "earnings#payslip", as: :employee_payslips
  get '/generate_payslip', to: "earnings#generate_payslip", as: :generate_payslip
end
