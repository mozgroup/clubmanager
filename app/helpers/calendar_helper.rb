module CalendarHelper
  def calendar(current_date, events)

    at_beginning_of_month = current_date.at_beginning_of_month
    at_end_of_month = current_date.at_end_of_month
    at_first_of_calendar = at_beginning_of_month.at_beginning_of_week(:sunday)
    at_end_of_calendar = at_end_of_month.at_end_of_week(:sunday)
    calendar_markup = []

    current_day = at_first_of_calendar
    begin
      calendar_markup << calendar_week(current_day, at_beginning_of_month, at_end_of_month, events)
      current_day += 1.week
    end while current_day <= at_end_of_calendar

    calendar_markup.join
  end

  def calendar_week(current_day, at_beginning_of_month, at_end_of_month, events)
    today = Date.current

    week_markup = ["<tr>"]
    7.times do |i|
      if current_day.sunday?
        week_markup << '<td class="week-end'
        week_markup << ' prev-month' if current_day < at_beginning_of_month
        week_markup << ' today' if current_day.strftime('%Y%m%d') == today.strftime('%Y%m%d')
        week_markup << '">'
      elsif current_day.saturday?
        week_markup << '<td class="week-end'
        week_markup << ' next-month' if current_day > at_end_of_month
        week_markup << ' today' if current_day.strftime('%Y%m%d') == today.strftime('%Y%m%d')
        week_markup << '">'
      else
        week_markup << '<td'
        week_markup << ' class="prev-month"' if current_day < at_beginning_of_month
        week_markup << ' class="next-month"' if current_day > at_end_of_month
        week_markup << ' class="today"' if current_day.strftime('%Y%m%d') == today.strftime('%Y%m%d')
        week_markup << '>'
      end
      week_markup << "<span class=\"cal-day\">#{current_day.mday}</span>"
      week_markup << daily_events(current_day, events)
      week_markup << "</td>"

      current_day += 1.day
    end
    week_markup << '</tr>'
    week_markup.join
  end

  def daily_events(current_day, events)
    daily_markup = ['<ul class="cal-events">']
    events.each { |event| daily_markup << "<li>#{event.subject}</li>" if event.start_at.mday == current_day.mday }
    daily_markup << '</ul>'
    daily_markup.join
  end
end
