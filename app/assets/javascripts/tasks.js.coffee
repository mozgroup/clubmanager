jQuery ->

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

#  if $('#task_assigned_to').length > 0
#    $('#task_assigned_to').autocomplete {
#      source: '/users/search'
#      minLength: 2
#      select: (event, ui) ->
#        this.value = ui.item.label
#        return false
#    }

  if $(".datepicker").length > 0
    $(".datepicker").datepicker {
      dateFormat: 'yy-mm-dd'
      changeMonth: true
      changeYear: true
      showButtonPanel: true
    }

  if $('#tablesorter').length > 0
    $('#tablesorter').tablesorter()

  $('#task-search-btn').on 'click', (event) ->
    $('#task-search').submit()

  $('#task-filter-btn').on 'click', (event) ->
    $('#task-filter').submit()
