jQuery ->
  if $('#checklist_assigned_to').length > 0
    $('#checklist_assigned_to').autocomplete {
      source: '/users/search'
      minLength: 2
      select: (event, ui) ->
        this.value = ui.item.label
        return false
      }

  $('form').on 'click', '.remove_fields', (event) ->
    $(@).prev('input[type=hidden]').val('1')
    $(@).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
  	time = new Date().getTime()
  	regexp = new RegExp($(@).data('id'), 'g')
  	$(@).before($(@).data('fields').replace(regexp, time))
  	event.preventDefault()