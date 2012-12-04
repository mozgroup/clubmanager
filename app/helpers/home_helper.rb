module HomeHelper

  def generate_agenda
    content_tag(:div, class: "agenda-wrapper") do
      agenda_event_tag
    end
  end

  def agenda_event_tag
    agenda_event = ''
    7.times do |i|
      agenda_event += content_tag(:div, class: "agenda-events agenda-day#{i+1}") do
        content_tag(:div, class: "agenda-header") do
          day_name(i+1)
        end
      end
    end
    agenda_event.html_safe
  end

  def day_name(day)
    day_name = case day
    when 1 then "Sunday"
    when 2 then "Monday"
    when 3 then "Tuesday"
    when 4 then "Wednesday"
    when 5 then "Thursday"
    when 6 then "Friday"
    when 7 then "Saturday" 
    end

    day_name
  end
end
