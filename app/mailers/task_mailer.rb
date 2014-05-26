class TaskMailer < ActionMailer::Base
  default from: "no-reply@myclubmanager.net"

  def assigned_task(task)
    @task = task
    @send_to = task.assignee
    @author = task.owner
    @subject = "A task has been assigned to you"

    mail(to: @send_to.email, subject: "[ClubManager] #{@subject}")
  end

  def claimed_task(task)
    @task = task
    @send_to = task.owner
    @assignee = task.assignee
    @subject = "A task has been claimed"

    mail(to: @send_to.email, subject: "[ClubManager] #{@subject}")
  end

  def completed_task(task)
    @task = task
    @send_to = task.owner
    @assignee = task.assignee
    @subject = "Task has been completed"

    mail(to: @send_to.email, subject: "[ClubManager] #{@subject}")
  end

  def overdue_task(task)
    @task = task
    @send_to = task.owner
    @assignee = task.assignee
    @subject = "Task is overdue"

    mail(to: @send_to, subject: "[ClubManager] #{@subject}")
  end

  def overdue_report(tasks)
    @tasks = tasks
    @send_to = 'workflow.forwarding@gmail.com'
    @subject = "Overdue Tasks Report"

    mail(to: @send_to, subject: "[ClubManager] #{@subject}")
  end
end
