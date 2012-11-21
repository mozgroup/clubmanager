module CalendarHelper
  def calendar(current_date)

    at_beginning_of_month = current_date.at_beginning_of_month
    at_end_of_month = current_date.at_end_of_month
    at_first_of_calendar = at_beginning_of_month.at_beginning_of_week(:sunday)
    at_end_of_calendar = at_end_of_month.at_end_of_week(:sunday)
    calendar_markup = []

    current_day = at_first_of_calendar
    begin
      calendar_markup << calendar_week(current_day, at_beginning_of_month, at_end_of_month)
      current_day += 1.week
    end while current_day <= at_end_of_calendar

    calendar_markup.join
  end

  def calendar_week(current_day, at_beginning_of_month, at_end_of_month)
    today = Date.current

    week_markup = ["<tr>"]
    7.times do |i|
      if current_day.sunday?
        week_markup << '<td class="week-end'
        week_markup << ' prev-month' if current_day < at_beginning_of_month
        week_markup << ' today' if current_day == today
        week_markup << '">'
      elsif current_day.saturday?
        week_markup << '<td class="week-end'
        week_markup << ' next-month' if current_day > at_end_of_month
        week_markup << ' today' if current_day == today
        week_markup << '">'
      else
        week_markup << '<td'
        week_markup << ' class="prev-month"' if current_day < at_beginning_of_month
        week_markup << ' class="next-month"' if current_day > at_end_of_month
        week_markup << ' class="today"' if current_day == today
        week_markup << '>'
      end
      week_markup << "<span class=\"cal-day\">#{current_day.mday}</span></td>"

      current_day += 1.day
    end
    week_markup << '</tr>'
    week_markup.join
  end
end
