$(document).ready(function()
{
  /*
   * JS login effect
   * This script will enable effects for the login page
   */
    // Elements
  var doc = $('html').addClass('js-login'),
    container = $('#container'),
    formLogin = $('#form-login'),

    // If layout is centered
    centered;

  /******* EDIT THIS SECTION *******/

  /*
   * AJAX login
   * This function will handle the login process through AJAX
   */
  formLogin.submit(function(event)
  {
    // Values
    var login = $.trim($('#email').val());

    // Check inputs
    if (login.length === 0)
    {
      // Display message
      displayError('Please fill in your email');
      return false;
    }
    else
    {
      // Remove previous messages
      formLogin.clearMessages();

      // Show progress
      displayLoading('Sending reset information...');

    }
  });

  /******* END OF EDIT SECTION *******/

  // Handle resizing (mostly for debugging)
  function handleLoginResize()
  {
    // Detect mode
    centered = (container.css('position') === 'absolute');

		// Set min-height for mobile layout
		if (!centered)
		{
			container.css('margin-top', '');
		}
		else
		{
			if (parseInt(container.css('margin-top'), 10) === 0)
			{
				centerForm(false);
			}
		}
	};

	// Register and first call
	$(window).bind('normalized-resize', handleLoginResize);
	handleLoginResize();

	/*
	 * Center function
	 * @param boolean animate whether or not to animate the position change
	 * @param string|element|array any jQuery selector, DOM element or set of DOM elements which should be ignored
	 * @return void
	 */
	function centerForm(animate, ignore)
	{
		// If layout is centered
		if (centered)
		{
			var siblings = formLogin.siblings(),
				finalSize = formLogin.outerHeight();

			// Ignored elements
			if (ignore)
			{
				siblings = siblings.not(ignore);
			}

			// Get other elements height
			siblings.each(function(i)
			{
				finalSize += $(this).outerHeight(true);
			});

			// Setup
			container[animate ? 'animate' : 'css']({ marginTop: -Math.round(finalSize/2)+'px' });
		}
	};

	// Initial vertical adjust
	centerForm(false);

	/**
	 * Function to display error messages
	 * @param string message the error to display
	 */
	function displayError(message)
	{
		// Show message
		var message = formLogin.message(message, {
			append: false,
			arrow: 'bottom',
			classes: ['red-gradient'],
			animate: false					// We'll do animation later, we need to know the message height first
		});

		// Vertical centering (where we need the message height)
		centerForm(true, 'fast');

		// Watch for closing and show with effect
		message.bind('endfade', function(event)
		{
			// This will be called once the message has faded away and is removed
			centerForm(true, message.get(0));

		}).hide().slideDown('fast');
	}

	/**
	 * Function to display loading messages
	 * @param string message the message to display
	 */
	function displayLoading(message)
	{
		// Show message
		var message = formLogin.message('<strong>'+message+'</strong>', {
			append: false,
			arrow: 'bottom',
			classes: ['blue-gradient', 'align-center'],
			stripes: true,
			darkStripes: false,
			closable: false,
			animate: false					// We'll do animation later, we need to know the message height first
		});

		// Vertical centering (where we need the message height)
		centerForm(true, 'fast');

		// Watch for closing and show with effect
		message.bind('endfade', function(event)
		{
			// This will be called once the message has faded away and is removed
			centerForm(true, message.get(0));

		}).hide().slideDown('fast');
	}
});

