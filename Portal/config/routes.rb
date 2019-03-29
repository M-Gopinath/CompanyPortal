Rails.application.routes.draw do
  devise_for :employees, :controllers => { :registrations => "employees/registrations"}
  
  get 'meeting_calendar/index'

  get 'dashboard/index'
  get 'dashboard/common'
  get 'dashboard/listing'
  get 'dashboard/active_listing'
  get 'dashboard/deactive_listing'
  put "dashboard/project/update/:id", to: "dashboard#update_project", as: :portal_project_update
  delete "dashboard/projects/:id", to: "dashboard#destroy_project", as: :portal_project_destroy
  put "dashboard/projects/deactive/:id", to: "dashboard#deactive_project", as: :portal_project_deactive
  post "dashboard/projects/create", to: "dashboard#create_project", as: :portal_project_create
  # leave permission
  get 'leave_permissions/leave_approve'
  get 'leave_permissions/leave_reject'
  get 'leave_permissions/leave_cancel'
  get 'leave_permissions/permission_approve'
  get 'leave_permissions/permission_cancel'
  get 'leave_permissions/permission_reject'
  delete 'leave_permissions/leave_destroy'
  delete 'leave_permissions/permission_destroy'
  #client
  get 'clients/active', to: "client_listings#active_clients", as: :active_clients
  get 'clients/deactive', to: "client_listings#deactive_clients", as: :deactive_clients
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

  #yearly_holiday_calendar
  resources :yearly_holiday_calendar
  # privacy_policies
  resources :privacy_policies
  #employee_agreements
  resources :employee_agreements, path: "employees/agreements"
  #employee_emergency_contact_details
  resources :employee_emergency_contact_details, path: "employees/emergency_contacts"
  #employee_bank_details
  resources :employee_bank_details
  # employee_listings
  get 'employees/active', to: "employee_listings#active_listing", as: :active_employees
  get 'employees/deactive', to: "employee_listings#deactive_listing", as: :deactive_employees
  get '/deactivate', to: "employee_listings#deactivate", as: :deactivate_employee
  get '/activate', to: "employee_listings#activate", as: :activate_employee
  #employee_education_details
  resources :employee_education_details, path: "employees/education_details"
  #employee_professional_details
  resources :employee_professional_details, path: "employees/professional_details"
  #employee_qualification_details
  resources :employee_qualification_details, path: "employees/qualifications"
  #employee_employment_details
  resources :employee_employment_details, path: "employees/employment_detail"
  #employee_languages
  resources :employee_languages, path: "employees/languages"
  #employee_addresses
  resources :employee_addresses, path: "employees/addresses"
  #employee_personal_details
  resources :employee_personal_details, path: "employees/personal_details"
  # finance Management
  namespace :finance_management do
    #office Incomes
    resources :office_incomes, only: [:index, :create, :update, :destroy]
    get '/income_client', to: "office_incomes#income_client"
    # Expenses
    resources :expenses, except: [:new]
    resources :office_salaries
    resources :balance_sheets, only: [:index]
    get '/shareholder_profit_loss', to: "balance_sheets#shareholder_profit_loss"
  end

  # Agreements
  get 'employee_agreements/bond_letter'
  get 'employee_agreements/experience_letter'
  get 'employee_agreements/relieving_letter'
  get 'employee_agreements/resignation_letter'
  get 'employee_agreements/joining_letter'
  
  devise_for :admins, :controllers => { :registrations => "registrations", :sessions => "sessions"}
  
  devise_scope :admin do
  	get 'check_employee', to: "registrations#check_employee", as: :check_employee
    post 'employees/employee_create', to: "registrations#employee_create", as: :employee_create
    put 'employees/employee_update', to: "registrations#employee_update", as: :employee_update
    get 'registrations/assign_supervisor'
  	authenticated :admin do
    	root 'dashboard#index', as: :authenticated_root
  	end

  	unauthenticated do
    	root 'sessions#new', as: :unauthenticated_root
  	end
  	
  end
 
end
