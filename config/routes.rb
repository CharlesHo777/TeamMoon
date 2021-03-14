Rails.application.routes.draw do

  devise_scope :admin_user do
      root to: 'admin_users/sessions#new'
      get '/admin/login', to: 'admin_users/sessions#new'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

end
