class TasksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @contexts = Context.by_name
  end

  def new
    @task = Task.new(owner_id: current_user.id)
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
end
