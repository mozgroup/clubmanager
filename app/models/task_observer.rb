class TaskObserver < ActiveRecord::Observer
  def after_assign(task, transition)
    task.log_task_asigned("Task #{task.name} has been assigned to #{task.assigned_to}", task.owner_full_name)
    Notifier::Tasks.deliver_assigned_task_message(task)
  end

  def before_claim(task, transition)
    task.claimed_at = Time.now.zone
  end

  def after_claim(task, transition)
    task.log_task_claimed("Task #{task.name} has been claimed by #{task.assigned_to}", task.owner_full_name)
    Notifier::Tasks.deliver_claim_task_message(task)
  end

  def before_start(task, transition)
    task.started_at = Time.now.zone
  end

  def after_start(task, transition)
    task.log_task_started("Task #{task.name} has been started by #{task.assigned_to}", task.owner_full_name)
  end

  def before_complete(task, transition)
    task.completed_at = Time.now.zone
  end

  def after_complete(task, transition)
    task.log_task_completed("Task #{task.name} has been complete by #{task.assigned_to}", task.owner_full_name)
    Notifier::Tasks.deliver_completed_task_message(task)
  end

  def before_save(task)
    if task.assignee_id_changed?
    end
  end

end
