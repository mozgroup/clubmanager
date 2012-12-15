jQuery ->

  editorTextarea = $('#message_body')
  editorWrapper = editorTextarea.parent()
  editor = editorTextarea.cleditor({
    width: '100%'
    height: 350
  })[0]

  if $('#message_send_to').length > 0
	  $('#message_send_to').bind "keydown", (event) ->
	    if event.keyCode == $.ui.keyCode.TAB && $(@).data("autocomplete").menu.active
	      event.preventDefault()
	  .autocomplete {
	      minLength: 2,
	      source: (request, response) ->
	        $.getJSON '/users/search.json', {
	          term: extractLast request.term
	        }, response
	      search: ->
	        term = extractLast @.value
	        if term.length < 2
	          false
	      focus: ->
	        false
	      select: (event, ui) ->
	        terms = split @.value
	        terms.pop()
	        terms.push ui.item.label
	        terms.push ""
	        @.value = terms.join ", "
	        false
	    }

  if $('#message_send_to').length > 0
	  $('#message_copy_to').bind "keydown", (event) ->
	    if event.keyCode == $.ui.keyCode.TAB && $(@).data("autocomplete").menu.active
	      event.preventDefault()
	  .autocomplete {
	      minLength: 2,
	      source: (request, response) ->
	        $.getJSON '/users/search.json', {
	          term: extractLast request.term
	        }, response
	      search: ->
	        term = extractLast @.value
	        if term.length < 2
	          false
	      focus: ->
	        false
	      select: (event, ui) ->
	        terms = split @.value
	        terms.pop()
	        terms.push ui.item.label
	        terms.push ""
	        @.value = terms.join ", "
	        false
	    }

  if $("#send-message").length > 0
    $("#send-message").bind 'click', (event) ->
      $("#action_type").val "send"
      $("form").submit()

  if $("#save-message").length > 0
    $("#save-message").bind 'click', (event) ->
      $("#action_type").value = "save"
      $("form").submit()

  if $("#delete-message").length > 0
  	$.confirm.defaults = {
  		message: 'Are you sure?'
  		confirmText: 'Confirm'
  		confirmClasses: ['blue-gradient', 'glossy']
  		cancel: true
  		cancelText: 'Cancel'
  		onConfirm: ->
  			$.ajax {
  				url: $(@).attr('href')
  				type: 'DELETE'
  			}
  	}

split = (val) ->
  val.split(/,\s*/)

extractLast = (term) ->
  split(term).pop()
