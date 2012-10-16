class TasksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_counts, except: [:update, :create]

  layout 'tasks'

  def index
    @contexts = Context.by_name
  end

  def new
    @task = Task.new(owner_id: current_user.id)
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      flash[:sucess] = "Task successfully updated!"
      redirect_to tasks_path
    else
      render 'edit'
    end
  end

  def my_tasks
    @tasks = current_user.top_tasks
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      flash[:success] = "Task created!"
      redirect_to tasks_path
    else
      render 'new'
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
