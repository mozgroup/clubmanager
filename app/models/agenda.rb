class Agenda
  
  class << self

    def find_by_date(date, user)
      agenda_array = []

      tasks = Task.by_assigned_user(user.id).for_week(date)
      user_events = UserEvent.for_user(user.id).for_week(date)

      tasks.each { |task| agenda_array << { id: task.id, type: 'task', title: task.name, agenda_date: task.due_at } }
      user_events.each { |ue| agenda_array << { id: ue.event_id, type: 'event', title: ue.event.subject, agenda_date: ue.event.start_at } }

      agenda_array.sort_by! { |agenda| agenda[:agenda_date] }
    end
  end

end
