class ApplicationController < ActionController::Base

  

    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username, :gender])
    end

    def index
    end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
    if resource.is_a?(Participant)
      user_root_path
    elsif resource.is_a?(AdminUser)
      admin_root_path
    elsif resource.is_a?(CoordUser)
      coord_root_path
    else
      super
    end
  end

     def can_administer?
       current_coord_user.try(:admin?)
     end

end

