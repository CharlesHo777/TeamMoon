ActiveAdmin::Devise::SessionsController.class_eval do
  def after_sign_out_path_for(resource)
    case resource
    when :coord_user then coord_root_url
    else super
    end
  end
end
