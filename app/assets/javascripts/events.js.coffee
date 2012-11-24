jQuery ->

  if $('#new-event-btn').length > 0
    $('#new-event-btn').click (event) ->
      $.modal {
        useIframe: true,
        title: 'New Event',
        url: $(@).attr('href'),
        height: 500,
        width: 400,
        resizeOnLoad: true,
        scrolling: false,
        buttons: {
          'Submit': (modal) -> $('.new_event').submit(),
          'Close': (modal) -> modal.closeModal(),
        },
        loadingMessage: 'Loading event form...'
      }
      event.preventDefault()

  if $('.event-link').length > 0
    $('.event-link').click (event) ->
      $.modal {
        title: 'Event',
        url: $(@).attr('href'),
        height: 500,
        resizeOnLoad: true,
        buttons: {
          'Close': (modal) -> modal.closeModal(),
        },
        loadingMessage: 'Loading event form...'
      }
      event.preventDefault()

  if $('#event_invitee_list').length > 0
    $('#event_invitee_list').autocomplete {
      source: '/users/search',
      minLength: 2,
      select: (event, ui) ->
        @.value = ui.item.label
        return false
    }
