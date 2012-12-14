class EnvelopesController < ApplicationController
  before_filter :authenticate_user!

  layout false

  def trash
    envelope = Envelope.find(params[:envelope_id])
    envelope.trash
  end

  def delete
    envelope = Envelope.find(params[:envelope_id])
    envelope.delete
  end

  def mark_important
    envelope = Envelope.find(params[:envelope_id])
    envelope.mark_important
  end
end
