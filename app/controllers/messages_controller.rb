class MessagesController < ApplicationController
  before_filter :authenticate_user!

  layout false

  def show
    @message = Message.find(params[:id])
    @envelope = @message.envelopes.current_envelope(current_user)
  end

  def new
    @message = current_user.authored_messages.build
  end

  def edit
    @message = Message.find(params[:id])
  end

  def create
    @message = current_user.authored_messages.build(params[:message])
    if @message.save
      save_response
    end
  end

  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(params[:message])
      save_response
    end
  end

  def reply
    @orig_msg = Message.find(params[:message_id])
    @message = @orig_msg.reply(params[:reply_type])
    render 'new'
  end

  def forward
    @message = Message.find(params[:message_id]).forward
    render 'new'
  end

  def trash
    message = Message.find params[:message_id]
    message.send_to_trash
    respond_to do |format|
      format.js { render 'close_message', layout: false }
    end
  end

  def destroy
    message = Message.find params[:id]
    message.destroy

    respond_to do |format|
      format.js { render 'close_message', layout: false }
    end
  end

  def cancel
  end

  private

    def save_response
      if params[:action_type] == 'send'
        @message.deliver
      end
      render 'close_message', locals: { action_type: params[:action_type] }
    end

end
