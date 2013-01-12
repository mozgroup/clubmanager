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
      @daily_incomplete = ChecklistItem.daily_incomplete_for_user(current_user.id)
      @weekly_incomplete = ChecklistItem.weekly_incomplete_for_user(current_user.id)
      @monthly_incomplete = ChecklistItem.monthly_incomplete_for_user(current_user.id)
    end
    helper_method :get_layout_data

  private

    def after_sign_out_path_for(resource_or_scope)
      new_session_path(resource_or_scope)
    end
end
