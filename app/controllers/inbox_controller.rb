class InboxController < ApplicationController
  def index
    @inbox = current_user.envelopes.inbox
    @unread_count = current_user.envelopes.unread_count
    @trash = current_user.envelopes.trash
    @sent = current_user.authored_messages.sent
    @drafts = current_user.authored_messages.drafts
  end
end
