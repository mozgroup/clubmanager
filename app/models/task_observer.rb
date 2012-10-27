class TaskObserver < ActiveRecord::Observer
  def after_assign(task, transition)
    task.log_task_asigned("Task #{task.name} has been assigned to #{task.assignee_full_name}", task.owner_full_name)
    send_assigned_message task
    # log transition
    # send email to assignee
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

  def send_assigned_message(task)
    author_id = task.owner_id
    send_to = task.assigned_to
    subject = 'You have been assigned a task'
    body = 'You have been assigned a task'

    message = Message.create(author_id: author_id, send_to: send_to, subject: subject, body: body)
    message.deliver

  end

end
