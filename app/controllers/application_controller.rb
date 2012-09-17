class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource

  before_filter :authenticate_user!

  protected

    def layout_by_resource
      if devise_controller?
        "session"
      else
        "application"
      end
    end

  private

    def after_sign_out_path_for(resource_or_scope)
      new_session_path(resource_or_scope)
    end
end
