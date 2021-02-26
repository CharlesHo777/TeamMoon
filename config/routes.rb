Rails.application.routes.draw do

  root to: 'application#redirect_to_admin_login'

  get '/login', to: 'application#redirect_to_admin_login'

  devise_for :admin_users, ActiveAdmin::Devise.config
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :coord_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

end
