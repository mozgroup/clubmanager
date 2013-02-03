jQuery ->
  event_list = ''

  new_buttons = [
    { text: 'Save Event', click: ->
      $('form').submit()
    }
    { text: 'Cancel', click: ->
      $('#dialog-event').dialog 'close'
    }]

  show_buttons = [
    { text: 'Close', click: ->
      $('#dialog-show-event').dialog 'close'
    }]

  $('#dialog-event').dialog
    width: 400
    height: 380
    autoOpen: false
    close: (event, ui) ->
      event_list.children().first().remove()
    buttons: new_buttons

  $('#dialog-show-event').dialog
    width: 400
    height: 380
    autoOpen: false
    buttons: show_buttons

  $('table.calendar tbody tr td').on 'click', (event) ->
    if $('#dialog-event').dialog 'isOpen'
      $('#dialog-event').dialog 'close'
      event_list.children().first().remove()
    else
      if $('#dialog-show-event').dialog 'isOpen'
        $('#dialog-show-event').dialog 'close'

      event_list = $(@).find 'ul.cal-events'

      pos = $(@).position()
      selected_date = $(@).attr 'data-cdate'

      event_list.prepend '<li>New Event</li>'

      $.get '/events/new?current_date='+selected_date, (data) ->
        $('#event-form').html data

      buttons = new_buttons
      $('#dialog-event').dialog 'open'

  $('table.calendar li a').on 'click', (event) ->
    # Stop the event from bubbling up
    event.stopPropagation()
    event.preventDefault()

    if $('#dialog-event').dialog 'isOpen'
      $('#dialog-event').dialog 'close'

    clicked_link =  $('table.calendar li a')
    if clicked_link.attr('updatable') == 'true'
      $.get $(@).attr('href'), (data) ->
        $('#event-form').html data
      $('#dialog-event').dialog 'open'
    else
      $.get $(@).attr('href'), (data) ->
        $('#show-event').html data
      $('#dialog-show-event').dialog 'open'
