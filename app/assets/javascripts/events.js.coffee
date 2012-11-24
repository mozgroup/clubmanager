jQuery ->
  $('#new-event-btn').click (event) ->
    $.modal {
      title: 'New Event',
      url: $(@).attr('href'),
      height: 500,
      resizeOnLoad: true,
      buttons: {
        'Submit': (modal) -> $('.new_event').submit(),
        'Close': (modal) -> modal.closeModal(),
      },
      loadingMessage: 'Loading event form...'
    }
    event.preventDefault()
