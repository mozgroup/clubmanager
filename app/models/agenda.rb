class Agenda
  
  class << self

    def find_by_date(date, user)
      agenda_array = []

      tasks = Task.by_assigned_user(user.id).for_week(date)
      events = Event.subscribed_to(user).for_week(date)

      tasks.each { |task| agenda_array << { id: task.id, type: 'task', title: task.name, start_at: task.due_at, end_at: task.due_at, agenda_time: task.due_at } }
      events.each { |event| agenda_array << { id: event.id, type: 'event', title: event.summary, start_at: event.starts_at_date, end_at: event.ends_at_date, agenda_time: event.starts_at_time } }

      agenda_array.sort_by! { |agenda| agenda[:agenda_date] }
    end
  end

end
