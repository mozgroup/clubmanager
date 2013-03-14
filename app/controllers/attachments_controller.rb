class AttachmentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @attachment = Attachment.new(params[:attachment])
    if @attachment.save
      redirect_to @attachment.attachable, notice: 'File was successfully attached'
    else
      redirect_to @attachment.attachable
    end
  end

  def destroy
    @attachment = Attachment.find params[:id]
    @attachment.destroy
    redirect_to @attachment.attachable
  end
end
