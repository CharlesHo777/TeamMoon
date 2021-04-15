ActiveAdmin::Devise::SessionsController.class_eval do
  def after_sign_out_path_for(resource)
    case resource
    when :admin_user then admin_root_url
    when :coord_user then coord_root_url
    when :participant then user_root_url
    else super
    end
  end
end
