require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TeamMars
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.to_prepare do
      Devise::SessionsController.layout "active_admin_logged_out"
      Devise::RegistrationsController.layout "active_admin_logged_out"
      # Devise::ConfirmationsController.layout ""
      # Devise::UnlocksController.layout ""
      Devise::PasswordsController.layout "active_admin_logged_out"
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

