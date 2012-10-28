class TaskObserver < ActiveRecord::Observer
  def after_assign(task, transition)
    task.log_task_asigned("Task #{task.name} has been assigned to #{task.assigned_to}", task.owner_full_name)
    Notifier::Tasks.deliver_assigned_task_message(task)
  end

  def after_claim(task, transition)
    # log transition
  end

  def after_start(task, transition)
    # log transition
  end

  def after_complete(task, transition)
    # log transition
    # send email to task owner
  end

  def before_save(task)
    if task.assignee_id_changed?
    end
  end

end
