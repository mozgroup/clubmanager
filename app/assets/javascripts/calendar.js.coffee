jQuery ->
  event_list = ''

  buttons = [
    { text: 'Save Event', click: ->
      $('form').submit()
    }
    { text: 'Cancel', click: ->
      $('#dialog-event').dialog 'close'
    }]

  $('#dialog-event').dialog
    width: 400
    height: 380
    autoOpen: false
    close: (event, ui) ->
      event_list.children().first().remove()
    buttons: buttons

  $('table.calendar tbody tr td').on 'click', (event) ->
    if $('#dialog-event').dialog 'isOpen'
      $('#dialog-event').dialog 'close'
      event_list.children().first().remove()
    else
      event_list = $(@).find 'ul.cal-events'

      pos = $(@).position()
      selected_date = $(@).attr 'data-cdate'

      event_list.prepend '<li>New Event</li>'

      $.get '/events/new?current_date='+selected_date, (data) ->
        $('#event-form').html data

      $('#dialog-event').dialog 'open'
