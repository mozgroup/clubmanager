jQuery ->
  $('.upload').on 'click', (event) ->
    if $('#attachment_item').val() == ''
      alert 'Please select a file to upload'
    else
      $('#file-upload').hide()
      $('#file-uploading').show()
      $(@).closest('form').submit()
