class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
    if resource.is_a?(AdminUser)
      admin_root_path
    elsif resource.is_a?(CoordUser)
      coord_root_path
    else
      super
    end
  end

end

# class AdminUsersController < ApplicationController
#
# end
#
# class CoordUsersController < ApplicationController
#
# end
