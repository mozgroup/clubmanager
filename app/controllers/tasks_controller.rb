class TasksController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  skip_load_resource :only => [:new, :index]
  before_filter :get_layout_data

  def index
    unless params[:query].blank?
      @tasks = Task.search_for params[:query]
    else
      unless params[:assigned_to].blank? && params[:status].blank? && params[:department].blank?
        @tasks = Task.search_assignee_and_state(params[:assigned_to], params[:status], params[:department])
      else
        @tasks = Task.by_name
      end
    end
  end

  def show
  end

  def new
    @task = Task.new(owner_id: current_user.id)
  end

  def edit
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      flash[:notice] = 'A task was successfully created.'
      redirect_to @task
    else
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      flash[:notice] = 'The task was successfully updated.'
      redirect_to @task
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = 'The task was deleted.'
    redirect_to tasks_url
  end

  def assign
  end

  def update_claimed
    @task = Task.find params[:id]
    @task.claim_task
    redirect_to @task
  end

  def start
    @task = Task.find params[:id]
    @task.start_task
    redirect_to @task
  end

  def complete
    @task = Task.find params[:id]
    @task.complete_task
    redirect_to @task
  end

  def rpt_all
    order = params[:order].blank? ? 'By Status' : params[:order].camelize
    if params[:order] == 'department'
      @tasks = Task.by_department
    elsif params[:order] == 'incomplete'
      @tasks = Task.in_process
    else
      @tasks = Task.by_state
    end
    respond_to do |format|
      format.html
      format.pdf do
        pdf = TaskPdf.new(@tasks, order)
        send_data pdf.render, filename: "tasks_by_state", type: "application/pdf", disposition: "inline"
      end
    end
  end

  def reports
    @tasks = Task.search_by_params params
    respond_to do |format|
      format.html
      format.pdf do
        pdf = TaskPdf.new(@tasks, 'Tasks')
        send_data pdf.render, filename: "tasks_by_state", type: "application/pdf", disposition: "inline"
      end
    end
  end

end
