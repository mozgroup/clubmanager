jQuery ->
  if $('#new-event-btn').length > 0
    $('#new-event-btn').click (event) ->
      $.modal {
        useIframe: true,
        title: 'New Event',
        url: $(@).attr('href'),
        height: 510,
        width: 500,
        resizeOnLoad: true,
        scrolling: false,
        buttons: {
          'Close': {
            classes: 'blue-gradient glossy big full-width'
            click: (modal) -> location.reload(); modal.closeModal()
          }
        },
        loadingMessage: 'Loading event form...'
      }
      event.preventDefault()

  if $('.event-link').length > 0
    $('.event-link').click (event) ->
      href = $(@).attr('href')
      updatable = $(@).attr('updatable')
      if updatable == 'true'
        btns =
          'Delete' : (modal) ->
            deleteEvent modal, href
          'Edit' : (modal) ->
            editEvent modal, href
          'Close': (modal) -> modal.closeModal()
      else
        btns =
          'Close': (modal) -> modal.closeModal()

      $.modal
        title: 'Event'
        url: href
        height: 500
        resizeOnLoad: true
        buttons: btns
        loadingMessage: 'Loading event form...'

      event.preventDefault()

  if $("#event_invitee_list").length > 0
    $("#event_invitee_list").bind "keydown", (event) ->
      if event.keyCode == $.ui.keyCode.TAB && $(@).data("autocomplete").menu.active
        event.preventDefault()
    .autocomplete {
      minLength: 2
      source: (request, response) ->
        $.getJSON '/users/search.json', {
          term: extractLast request.term
        }, response
      search: ->
        term = extractLast @.value
        if term.length > 2
          return false
      focus: ->
        return false
      select: (event, ui) ->
        terms = split @.value
        terms.pop()
        terms.push ui.item.label
        terms.push ""
        @.value = terms.join ", "
        return false
    }

split = (val) ->
  val.split /,\s*/

extractLast = (term) ->
  split(term).pop()

editEvent = (modal, link) ->
  modal.closeModal()

  $.modal {
    useIframe: true,
    title: 'New Event',
    height: 510,
    width: 500,
    url: link + '/edit'
    resizeOnLoad: true,
    scrolling: false,
    buttons: {
      'Close': {
        classes: 'blue-gradient glossy big full-width'
        click: (modal) -> location.reload(); modal.closeModal()
      }
    },
    loadingMessage: 'Loading event form...'
  }
  event.preventDefault()

deleteEvent = (modal, href) ->
  if confirm 'Are you sure you want to delete this event?'
    $.ajax
      url: href
      type: 'DELETE'
      success: (data) ->
        location.reload()
        modal.closeModal()
