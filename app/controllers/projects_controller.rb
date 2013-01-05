class ProjectsController < ApplicationController

  def index
    @projects = Project.by_name
  end

  def search
    contexts = Project.name_search params[:term]

    respond_to do |format|
      format.json { render json: contexts.collect { |c| c.name } }
    end
  end
end
