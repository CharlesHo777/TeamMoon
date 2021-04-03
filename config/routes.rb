Rails.application.routes.draw do

  # devise_for :admin_users, path: 'admin_users', controllers: { sessions: "admin_users/sessions" }
  # devise_for :coord_users, path: 'coord_users', controllers: { sessions: "coord_users/sessions" }

  devise_for :admin_users, ActiveAdmin::Devise.config.merge({path: '/admin'})
  devise_for :coord_users, ActiveAdmin::Devise.config.merge({path: '/coord'})

  ActiveAdmin.routes(self)

  devise_scope :admin_user do
    get '/admin/login', to: 'admin_users/sessions#new'
    get '/admin', to: 'admin_users/sessions#new'
    get '/administrator', to: 'admin_users/sessions#new'

    post '/admin_users/sign_in', to: 'admin_users/sessions#create'
    delete '/admin_users/sign_out', to: 'admin_users/sessions#destroy'
  end

  as :admin_user do
    get 'admin_users/edit' => 'devise/registrations#edit', :as => 'edit_admin_user_registration'
    put 'admin_users' => 'devise/registrations#update', :as => 'admin_user_registration'
  end

  namespace :admin do
    resources :dashboard, :admin_users, :coord_users, :buddy_schemes, :participants
  end

  devise_scope :coord_user do
    root to: 'coord_users/sessions#new'

    get '/coord/login', to: 'coord_users/sessions#new'
    get '/coord', to: 'coord_users/sessions#new'
    get '/coordinator', to: 'coord_users/sessions#new'

    post '/coord_users/sign_in', to: 'coord_users/sessions#create'
    delete '/coord_users/sign_out', to: 'coord_users/sessions#destroy'
  end

  namespace :coord do
    resources :dashboard, :admin_users, :coord_users, :buddy_schemes, :participants
  end

end
