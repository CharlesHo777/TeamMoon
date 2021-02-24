class ApplicationController < ActionController::Base

  def redirect_to_admin_login
    redirect_to('/admin/login')
  end

end
