jQuery ->
  $('table.calendar tbody tr td').on 'click', (event) ->
    pos = $(@).position()
    selected_date = $(@).attr 'data-cdate'

    event_list = $(@).find 'ul.cal-events'
    event_list.prepend '<li>New Event</li>'

    $('.calendar_event_editor').show()
    $('.balloon').position
      my: "left top"
      at: "right top"
      of: @
      collision: "fit"

    $.get '/events/new?current_date='+selected_date, (data) ->
      $('.balloon').html data
