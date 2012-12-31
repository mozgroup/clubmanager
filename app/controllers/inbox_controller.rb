class InboxController < ApplicationController
  before_filter :authenticate_user!, :get_navigation, :get_layout_data

  def index
  end

  def refresh
  	render layout: false
  end

  private

  	def get_navigation
	    @inbox = current_user.envelopes.inbox
	    @unread_count = current_user.envelopes.unread_count
	    @trash = current_user.envelopes.trash
	    @sent = current_user.authored_messages.sent
	    @drafts = current_user.authored_messages.drafts
  	end
end
