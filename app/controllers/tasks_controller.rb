class TasksController < TasksBaseController

  def index
    @tasks = current_user.top_tasks
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
    render layout: nil
  end

  def update_assigned_to
    @task = Task.find params[:id]
    @task.update_assigned_to params[:task][:assigned_to]
    redirect_to @task
  end
end
