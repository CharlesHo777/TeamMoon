# frozen_string_literal: true

class Participants::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    Devise::SessionsController.layout "active_admin_logged_out"
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  private

  # If you have extra params to permit, append them to the sanitizer.
  def sign_in_params
    super
  end
  
end
