jQuery ->
  $.template.addSetupFunction (self, children) ->
    initBindings()
  , false
  $('#calendar-body').applySetup()

initBindings = ->
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

