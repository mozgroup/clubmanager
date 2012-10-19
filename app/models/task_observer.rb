class TaskObserver < ActiveRecord::Observer
  def after_assign(task, transition)
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
end
