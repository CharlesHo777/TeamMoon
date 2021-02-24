Rails.application.routes.draw do

  root to: 'application#redirect_to_admin_login'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/login', to: 'application#redirect_to_admin_login'
  

end
