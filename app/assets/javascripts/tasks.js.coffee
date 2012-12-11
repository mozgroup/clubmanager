# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->

  $.template.init()
  
  if $('#formID').length > 0
    # if this is an edit or new form
    $("#formID").validationEngine()

  if $(".datepicker").length > 0
    $(".datepicker").glDatePicker({ zIndex: 100, dateFormat: "yy-mm-dd" })

  if $('#task_context_name').length > 0
    $('#task_context_name').autocomplete {
      source: '/contexts/search'
      minLength: 2
      }

  if $('#task_project_name').length > 0
    $('#task_project_name').autocomplete {
      source: '/projects/search'
      minLength: 2
      }

  if $('#task_assigned_to').length > 0
    $('#task_assigned_to').autocomplete {
      source: '/users/search'
      minLength: 2
      select: (event, ui) ->
        this.value = ui.item.label
        return false
      }

  if $('#task-assign').length > 0
    $('#task-assign').click (event) ->
      $.modal {
        title: 'Assign Task',
        url: $(@).attr('href'),
        resizeOnLoad: true,
        buttons: {
          'Submit': (modal) -> $('.edit_task').submit()
          'Close': (modal) -> modal.closeModal(),
        },
        loadingMessage: 'Loading task...'
      }

      event.preventDefault()
