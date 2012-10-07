class ContextsController < ApplicationController
  before_filter :authenticate_user!

  def search
    contexts = Context.name_search params[:term]

    respond_to do |format|
      format.json { render json: contexts.collect { |c| c.name } }
    end
  end
end
