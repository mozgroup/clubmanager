class MessageController < ApplicationController
  def show
    @message = Message.find(params[:id])
  end
end
