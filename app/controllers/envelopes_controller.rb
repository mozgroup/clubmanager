class EnvelopesController < ApplicationController
  before_filter :authenticate_user!

  layout false

  def trash
    envelope = Envelope.find(params[:envelope_id])
    envelope.trash
    get_navigation
  end

  def delete
    envelope = Envelope.find(params[:envelope_id])
    envelope.delete
  end

  def mark_important
    envelope = Envelope.find(params[:envelope_id])
    envelope.mark_important
  end

    def destroy
    message = Message.find params[:id]
    message.destroy
    get_navigation
    render 'close_message', layout: false, locals: { action_type: 'delete' }
  end

  protected
  
    def get_navigation
      @inbox = current_user.envelopes.inbox
      @unread_count = current_user.envelopes.unread_count
      @trash = current_user.envelopes.trash
      @sent = current_user.authored_messages.sent
      @drafts = current_user.authored_messages.drafts
    end

end
