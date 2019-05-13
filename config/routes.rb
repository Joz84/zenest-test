Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  devise_scope :user do
    get 'employee/users/sign_up', to: 'employee/registrations#new'
    post '/employee/user', to: 'employee/registrations#create'
    get 'employee/users/edit', to: 'employee/registrations#edit'
    put 'employee/users', to: 'employee/registrations#update'
    get 'praticien/users/edit', to: 'praticien/registrations#edit'
    put 'praticien/users', to: 'praticien/registrations#update'
  end
  #Pages
  root to: 'pages#home'
  get '/legal', to: 'pages#legal', as: 'legal'
  get '/cgv', to: 'pages#cgv', as: 'cgv'
  get '/charte', to: 'pages#charte', as: 'charte'

  resources :blog_articles, path: "blog-bien-etre-entreprise", as: :blog, only: [:index, :show]
  resources "contacts", only: [:create]
  get 'contacts-devis', to: 'contacts#new', as: 'new_contact'

  #Employee
  namespace :employee do
    resources :events, only: [:index]
    resources :attendees, only: [:new, :create, :update]
  end

  get 'employee/calendar_day/:calendar_day_id/available_massage_categories',
      to: 'employee/calendar_days#available_massage_categories',
      as: 'available_massage_categories_json',
      defaults: { format: :json }

  #Admin
  namespace :admin do
    resources :default_events, only: [:create, :update, :destroy]
    resources :event_groups, only: [] do
      resources :event_series, only: [:create]
    end
  end

  #Praticien
  namespace :praticien do
    resources :events, only: [:index]
    get '/print', to: 'events#print', as: 'print'
    get '/print_planning_day', to: 'events#print_planning_day', as: 'print_planning_day'
    resources :invoices, only: [:index, :create, :update]
    resources :availabilities, only: [:index, :update]
  end

  #AdminCompany
  namespace :admin_employee do
    resources :events, only: [:index, :update, :show] do
      resources :attendees, only: [:create]
    end
    get '/print', to: 'events#print', as: 'print'
    get '/print_planning_day', to: 'events#print_planning_day', as: 'print_planning_day'
    resources :rooms, only: [:index, :edit, :create, :update, :destroy]
    resources :attendees, only: [:new, :create, :update]
    resources :invoices, only: [:index]
  end

  get 'admin_employee/calendar_day/:calendar_day_id/available_massage_categories',
      to: 'admin_employee/calendar_days#available_massage_categories',
      as: 'admin_available_massage_categories_json',
      defaults: { format: :json }
end
