jQuery ->
  doc = $('html').addClass('js-login')
  container = $('#container')
  formLogin = $('#form-login')
  centered = ''

  formLogin.submit ->
    login = $.trim $('#user_email').val()
    pass = $.trim $('#user_password').val()
    pass_conf = $.trim $('#user_password_confirmation').val()

    formLogin.clearMessages()

    if $('#user_email').length > 0 && login.length == 0
      displayError 'Please fill in your email'
      return false
    else
      if $('#user_password').length > 0 &&  pass.length == 0
        displayError 'Please fill in your password'
        return false
      else
        if $('#user_password_confirmation').length > 0 && pass_conf.length == 0
          displayError 'Please fill in your password confirmation'
          return false
        else
          displayLoading 'Checking credentials...'


  handleLoginResize = ->
    centered = container.css('position') == 'absolute'
    unless centered
      container.css 'margin-top', ''
    else
      if parseInt(container.css('margin-top'), 10) == 0
        centerForm false

  centerForm = (animate, ignore) ->
    if centered
      siblings = formLogin.siblings()
      finalSize = formLogin.outerHeight()

      siblings = siblings.not(ignore) if ignore

      siblings.each (i) -> 
        finalSize += $(@).outerHeight true

      container[if animate then 'animate' else 'css'] { marginTop: -Math.round(finalSize/2)+'px' }

  $(window).bind 'normalized-resize', handleLoginResize
  handleLoginResize()

  centerForm false

  displayError = (message) ->
    msgParams =
      append: false
      arrow: 'bottom'
      classes: ['red-gradient']
      animate: false

    message = formLogin.message message, msgParams

    centerForm true, 'fast'

    message.bind 'endFade',(event) ->
      centerForm true, message.get 0
    .hide().slideDown 'fast'

  displayLoading = (message) ->
    msgParams = 
      append: false
      arrow: 'bottom'
      classes: ['blue-gradient', 'align-center']
      stripes: true
      darkStripes: false
      closable: false
      animate: false

    message = formLogin.message '<strong>'+message+'</strong>', msgParams

    centerForm true, 'fast'

    message.bind 'endFade', (event) ->
      centerForm true, message.get 0
    .hide().slideDown 'fast'
