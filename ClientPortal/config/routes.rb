Rails.application.routes.draw do
  get 'yearly_holiday_calendar/index'

  get 'meeting_calendar/index'

  get 'dashboard/index'
  get 'dashboard/edit_profile'
  post 'dashboard/update_client'
  post 'dashboard/create_client_company'
  get 'dashboard/company'
  post 'dashboard/update_same_address'
  root 'dashboard#index'
  delete 'feedbacks/remove_feedback'
  post 'feedbacks/create_feedback'
  get 'feedbacks/project_employee'
  put 'feedbacks/update_feedback/:id' => "feedbacks#update_feedback", as: :feedbacks_update_feedback
  resources :feedbacks
  resources :privacy_policies
  resources :projects do
    delete "/remove_project" => "projects#remove_project",as: :remove_project
    put "/edit_project" => "projects#edit_project",as: :edit_project
    post "/task" => "projects#task_create",as: :client_task_create
    put "/task/:task_id" => "projects#task_update",as: :client_task_update
    put "/update_status/:task_id" => "projects#task_update_status",as: :client_task_update_status
    get "/list" => "projects#projects_list", on: :collection
    put 'task_update/:task_id/comments' => 'projects#task_comments_update', as: :task_comments_update
    get "time_sheet" => "projects#time_sheet",as: :time_sheet, on: :collection
  end
  devise_for :clients, controllers: { omniauth_callbacks: 'clients/omniauth_callbacks' }
  devise_scope :client do
  	
  	authenticated :client do
  		root 'dashboard#index', as: :authenticated_root
  	end

  	unauthenticated do
  		root 'sessions#new', as: :unauthenticated_root
  	end
  	
  end
end
