class TasksController < TasksBaseController

  def index
    @tasks = current_user.tasks
  end

  def new
    @task = Task.new(owner_id: current_user.id, assignee_id: current_user.id)
    render layout: false
  end

  def edit
    @task = Task.find(params[:id])
    render layout: false
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      flash[:sucess] = "Task successfully updated!"
    else
      render 'edit'
    end
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      flash[:success] = "Task created!"
    else
      render 'new'
    end
  end

  def show
    @task = Task.find params[:id]
    render layout: false
  end

  def assign
    @task = Task.find params[:id]
    render layout: false
  end

  def update_assigned_to
    @task = Task.find params[:id]
    @task.update_assigned_to params[:task][:assigned_to]
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def update_claimed
    @task = Task.find params[:id]
    @task.claim_task
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def start
    @task = Task.find params[:id]
    @task.start_task
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def complete
    @task = Task.find params[:id]
    @task.complete_task
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def my_tasks
    @tasks = current_user.tasks
    render layout: false
  end

  def assigned
    @tasks = current_user.tasks.assigned
    render layout: false
  end

  def in_progress
    @tasks = current_user.tasks.started
    render layout: false
  end

  def completed
    @tasks = current_user.tasks.completed
    render layout: false
  end

  def context
    @tasks = Task.by_context(params[:context_id])
    render layout: false
  end

  def project
    @tasks = Task.by_project(params[:project_id])
    render layout: false
  end
end
