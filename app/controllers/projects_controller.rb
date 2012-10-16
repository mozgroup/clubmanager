class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_counts, except: [:update, :create]

  layout 'tasks'


  def index
    @projects = Project.by_name
  end

  def search
    contexts = Project.name_search params[:term]

    respond_to do |format|
      format.json { render json: contexts.collect { |c| c.name } }
    end
  end

  private

    def get_counts
      @my_count = current_user.tasks.count
      @all_count = Task.count
      @project_count = Project.count
      @context_count = Context.count
      @top_tasks = current_user.top_tasks
    end
end
