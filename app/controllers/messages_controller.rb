class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_layout_data


  layout false, except: :index

  def index
    mailbox = current_user.mailboxes[0]
    imap = ImapReader.new(host: mailbox.host, username: mailbox.username, password: 'tad5150')
    @folders = imap.folders
  end

  def inbox
  end

  def drafts
    @messaages = Message.belonging_to(current_user).drafts
  end

  def sent
    @messaages = Message.belonging_to(current_user).sent
  end

  def trash
    @messaages = Message.belonging_to(current_user).trash
  end


#  def show
#    get_navigation
#    @message = Message.find(params[:id])
#    @envelope = @message.envelopes.current_envelope(current_user)
#  end
#
#  def new
#    @message = current_user.authored_messages.build
#  end
#
#  def edit
#    @message = Message.find(params[:id])
#  end
#
#  def create
#    @message = current_user.authored_messages.build(params[:message])
#    if @message.save
#      save_response
#    end
#  end
#
#  def update
#    @message = Message.find(params[:id])
#    if @message.update_attributes(params[:message])
#      save_response
#    end
#  end
#
#  def reply
#    @orig_msg = Message.find(params[:message_id])
#    @message = @orig_msg.reply(params[:reply_type])
#    render 'new'
#  end
#
#  def forward
#    @message = Message.find(params[:message_id]).forward
#    render 'new'
#  end
#
#  def trash
#    message = Message.find params[:message_id]
#    message.send_to_trash
#    render 'close_message', layout: false
#  end
#
#  def destroy
#    message = Message.find params[:id]
#    message.destroy
#    get_navigation
#    render 'close_message', layout: false, locals: { action_type: 'delete' }
#  end
#
#  def cancel
#  end
#
  private

    def save_response
      if params[:action_type] == 'send'
        @message.deliver
      end
      get_navigation
      render 'close_message', locals: { action_type: params[:action_type] }
    end

    def get_navigation
      @inbox = current_user.envelopes.inbox
      @unread_count = current_user.envelopes.unread_count
      @trash = current_user.envelopes.trash
      @sent = current_user.authored_messages.sent
      @drafts = current_user.authored_messages.drafts
    end

end
