# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->

  $("#formID").validationEngine()
  $(".datepicker").datepicker({ dateFormat: "yy-mm-dd" })

  $('#task_context_name').autocomplete {
    source: '/contexts/search'
    minLength: 2
    }

  $('#task_project_name').autocomplete {
    source: '/projects/search'
    minLength: 2
    }

  $('#task_assigned_to').autocomplete {
    source: '/users/search'
    minLength: 2
    select: (event, ui) ->
      this.value = ui.item.label
      return false
    }
