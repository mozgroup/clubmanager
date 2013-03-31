class TaskObserver < ActiveRecord::Observer
  def after_assign(task, transition)
    task.log_task_asigned("Task #{task.name} has been assigned to #{task.assigned_to}", task.owner_full_name)
    TaskMailer.assigned_task(task).deliver
  end

  def after_claim(task, transition)
    task.update_column('claimed_at', Time.now)
    task.log_task_claimed("Task #{task.name} has been claimed by #{task.assigned_to}", task.owner_full_name)
    TaskMailer.claimed_task(task).deliver
  end

  def after_start(task, transition)
    task.update_column('started_at', Time.now)
    task.log_task_started("Task #{task.name} has been started by #{task.assigned_to}", task.owner_full_name)
  end

  def after_complete(task, transition)
    task.update_column('completed_at', Time.now)
    task.log_task_completed("Task #{task.name} has been complete by #{task.assigned_to}", task.owner_full_name)
    TaskMailer.completed_task(task).deliver
  end

  def before_create(task)
    unless task.assignee_id.blank?
      task.state = "assigned"
      TaskMailer.assigned_task(task).deliver
    end
  end

end
