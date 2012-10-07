split = (val) ->
  val.split /,\s*/

extractLast = (term) ->
  split(term).pop()

ac_params = {
  minLength: 2
  source: (request, response) -> 
    $.getJSON @.data-search_path,
    { term: extractLast request.term }, response
  search: ->
    term = extractLast @.value
    if term.length < 2
      return false
  focus: ->
    return false
  select: (event, ui) ->
    terms = split @.value
    terms.pop()
    terms.push ui.item.label
    terms.push ""
    @.value = terms.toin ", "
    return false
}

#temp_func = ->
#  if event.keyCode == $.ui.keyCode.TAB && $(@).data("autocomplete").menu.active
#    event.preventDefault()
#.autocomplete ac_params

