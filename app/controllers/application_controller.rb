class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource

  protected

    def layout_by_resource
      if devise_controller?
        "session"
      else
        "application"
      end
    end

    def get_layout_data
      @unread_envelopes = Envelope.for_recipient(current_user.id).unread.limit(4)
      @incomplete_tasks = ChecklistItem.daily_incomplete_for_user(current_user.id).slice(0,3)
    end
    helper_method :get_layout_data

  private

    def after_sign_out_path_for(resource_or_scope)
      new_session_path(resource_or_scope)
    end
end
