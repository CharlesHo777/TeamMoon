Rails.application.routes.draw do

  mount Rapidfire::Engine => "/rapidfire"

  # devise_for :admin_users, path: 'admin_users', controllers: { sessions: "admin_users/sessions" }
  # devise_for :coord_users, path: 'coord_users', controllers: { sessions: "coord_users/sessions" }
  devise_for :participants, :controllers => { :registrations => 'participants/registrations' }

  # devise_for :participants, ActiveAdmin::Devise.config.merge({path: '/user'})
  devise_for :admin_users, ActiveAdmin::Devise.config.merge({path: '/admin'})
  devise_for :coord_users, ActiveAdmin::Devise.config.merge({path: '/coord'})

  ActiveAdmin.routes(self)

  devise_scope :participant do
    root to: 'participants/sessions#new'
    get '/login', to: 'participants/sessions#new'

    get '/user/login', to: 'participants/sessions#new'
    get '/user', to: 'participants/sessions#new'
    get '/participant', to: 'participants/sessions#new'

    post '/participants/sign_in', to: 'participants/sessions#create'
    delete '/participants/sign_out', to: 'participants/sessions#destroy'
  end

  # as :participant do
  #   get 'participants/edit' => 'devise/registrations#edit', :as => 'edit_participant_registration'
  #   put 'participants' => 'devise/registrations#update', :as => 'participant_registration'
  # end

  namespace :user do
    resources :dashboard, :admin_users, :coord_users, :buddy_schemes, :participants
  end

  devise_scope :admin_user do
    get '/admin/login', to: 'admin_users/sessions#new'
    get '/admin', to: 'admin_users/sessions#new'
    get '/administrator', to: 'admin_users/sessions#new'

    post '/admin_users/sign_in', to: 'admin_users/sessions#create'
    delete '/admin_users/sign_out', to: 'admin_users/sessions#destroy'

    get 'admin_users/edit' => 'devise/registrations#edit', :as => 'edit_admin_user_registration'
    put 'admin_users' => 'devise/registrations#update', :as => 'admin_user_registration'
  end

  namespace :admin do
    resources :dashboard, :admin_users, :coord_users, :buddy_schemes, :participants
  end

  devise_scope :coord_user do

    get '/coord/login', to: 'coord_users/sessions#new'
    get '/coord', to: 'coord_users/sessions#new'
    get '/coordinator', to: 'coord_users/sessions#new'

    post '/coord_users/sign_in', to: 'coord_users/sessions#create'
    delete '/coord_users/sign_out', to: 'coord_users/sessions#destroy'

    get 'coord_users/edit' => 'devise/registrations#edit', :as => 'edit_coord_user_registration'
    put 'coord_users' => 'devise/registrations#update', :as => 'coord_user_registration'
  end

  namespace :coord do
    resources :dashboard, :admin_users, :coord_users, :buddy_schemes, :participants
  end

end
