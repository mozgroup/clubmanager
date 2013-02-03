jQuery ->
  # Initialize the date picker
  $(".starts_at_datepicker").datepicker
    dateFormat : 'DD, MM d, yy'
    altField : '.ends_at_datepicker'
    altFormat : 'DD, MM d, yy'
  $(".ends_at_datepicker").datepicker
    dateFormat : 'DD, MM d, yy'

  # Setup the time conversion
  $('#event_start_time').on 'blur', (event) ->
    time_val = $(@).val().trim()
    if !isFormattedTime time_val
      time_parts = time_val.match /^(\d+)(:\d+)?$/
      hour = parseInt time_parts[1]
      meridian = 'am'

      if hour > 11
        meridian = 'pm'
      if hour > 12
        hour = hour - 12
      if time_parts[2] == undefined
        time_parts[2] = ''

      $(@).val hour + time_parts[2] + meridian

  # Invite others hooks
  $('.invite-others').on 'click', (event) ->
    $(@).hide()
    $(@).next().show().focus()

  # Autocomplete for subscribers
    $('#event_subscription_names').on 'keydown', (event) ->
      if event.keyCode == $.ui.keyCode.TAB && $(@).data("autocomplete").menu.active
        event.preventDefault()
    .autocomplete
      minLength: 2
      source: (request, response) ->
        $.getJSON '/users/search.json',
          term: extractLast request.term
        , response
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

  $('.date_range').on 'click', (event) ->
    $(@).hide()
    $('.ends_at_date').show()

split = (val) ->
  val.split /,\s*/

extractLast = (term) ->
  split(term).pop()

isFormattedTime = (time_val) ->
  isFormatted_re = /^(\d[:\d]*)(am|pm)$/
  return String(time_val).search(isFormatted_re) != -1
