class TasksController < TasksBaseController

  layout false

  def index
    @tasks = current_user.tasks
  end

  def new
    @task = Task.new(owner_id: current_user.id, assignee_id: current_user.id)
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      flash[:sucess] = "Task successfully updated!"
      redirect_to @task
    else
      render 'edit'
    end
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

  def show
    @task = Task.find params[:id]
  end

  def assign
    @task = Task.find params[:id]
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
  end

  def assigned
    @tasks = current_user.tasks.assigned
  end

  def in_progress
    @tasks = current_user.tasks.started
  end

  def completed
    @tasks = current_user.tasks.completed
  end

  def context
    @tasks = Task.by_context(params[:context_id])
  end

  def project
    @tasks = Task.by_project(params[:project_id])
  end
end
