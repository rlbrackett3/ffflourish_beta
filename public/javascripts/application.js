// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


$(document).ready(function(){

//////////////////////////////////////////////////////////////
  // jquery validate-fields
  new ValidatedFields(
    // function called when validation fails
    function(element, errorMsg) {
      element.css('border', '1px #ff5e5a solid');
      element.prev('span.error').html(errorMsg); // show error message
    },

    // function called when validation succeeds
    function(element) {
      element.css('border', '1px #31f48e solid');
      element.prev('span.error').html(''); // clear error message
    }
  );

//////////////////////////////////////////////////////////////
  // jquery fancybox
  $("a.feed_entry_image").fancybox({
    'padding'             : 0,
    'margin'              : 0,
    'autoScale'           : false,
    'autoDimension'       : false,
		'transitionIn'	      :	'elastic',
		'transitionOut'	      :	'elastic',
		'speedIn'		          :	600, 
		'speedOut'		        :	200, 
		'overlayShow'	        :	true,
		'overlayOpacity'      : 0.5,
		'overlayColor'        : '#e5e5e5',
		'hideOnContentClick'  : true,
		'showCloseButton'     : false
	});
	
	$("a#random_ffflourish_link").fancybox({
		'padding'             : 0,
    'margin'              : 0,
    'scrolling'           : false,
    'centerOnScroll'      : true,
		'transitionIn'	      :	'fade',
		'transitionOut'	      :	'fade',
		'speedIn'		          :	600, 
		'speedOut'		        :	200, 
		'overlayShow'	        :	false,
		'overlayOpacity'      : 0.75,
		'overlayColor'        : '#e5e5e5',
	  'showCloseButton'     : true,
	  'hideOnOverlayClick'  : false
	});
	
//////////////////////////////////////////////////////////////
  // toggle post options icons
  $('#post_submit').hide();
  $('#post_content').focus(function() {
    $('#posting_options').slideDown(1000);
    $('#post_options_container').fadeIn(1200);
    $('#post_submit').fadeIn(1200);
    $('#countdown').fadeIn(1000);
  });

  $('img#post_image').click(function() {
    $('#post_fields_container').show(250, function() {
      $('.post_image_fields').toggle(1000, function() {});
    });
  });

//////////////////////////////////////////////////////////////
  // textarea countdown function
  $('textarea').keyup(function(){
    if(this.value.length >= 200) {
      //handle the over the limit part here
      $(this).addClass('overlimit');
      this.value = this.value.substring(0, 200);
    } else {
      $(this).removeClass('overlimit');
    }
    $('#counter').text(200-this.value.length);
  });
  
  $('input#profile_handle').focus(function() {
    $('#countdown').show();
  });
  $('input#profile_handle').keyup(function(){
    if(this.value.length >= 84) {
      //handle the over the limit part here
      $(this).addClass('overlimit');
      this.value = this.value.substring(0, 84);
    } else {
      $(this).removeClass('overlimit');
    }
    $('#counter').text(84-this.value.length);
  });

//////////////////////////////////////////////////////////////
  // textarea autoResize
  $('textarea#post_content, .comment_field').autoResize({
    // On resize:
    onResize : function() {
        $(this).css({opacity:0.8});
    },
    // After resize:
    animateCallback : function() {
        $(this).css({opacity:1});
    },
    // Quite slow animation:
    animateDuration : 300,
    // More extra space:
    extraSpace : 0
});

//////////////////////////////////////////////////////////////
  // onblur and onfocus functions for text areas

  $(function() {

    var postText = $('#post_content').val();

    $('#post_content').focus(function() {
	      if ( this.value == postText ) {
	        this.value = ''
	      }
      }).blur(function() {
	      if ( !$.trim( this.value ) ) {
	        this.value = postText
	      }
	    });
	    
    // error handling for textarea value
	  $('#post_submit').live("click", function() {
	  
      $('.errors').hide();
      var hasError = false;
	    var postFormVal = $('#post_content').val();

	    if ( postFormVal == '' ) {
	      $('p.errors').replaceWith('<p class="errors">Oops! your post was empty.</p>').show();
        hasError = true;
        $('p.errors').fadeOut(3000);
	    }
	    else if ( postFormVal.length < 5 ) {
	      $('p.errors').replaceWith('<p class="errors">Oops! your post was too short.</p>').slideDown(2000);
        hasError = true;
        $('p.errors').fadeOut(3000);
	    }
	    else if( postFormVal == postText ) {
	      $('p.errors').replaceWith('<p class="errors">That\'s what we are asking you.</p>').show();
	      hasError = true;
	      $('p.errors').fadeOut(3000);
	    };
      if (hasError == true) {
        //hasError = false;
        return false;
      }
      else {
        return true;
      };
      
	  });
  });

//////////////////////////////////////////////////////////////
  // flash notice and alert messages
  $(function () {
    var alert = $('.alert');
    if (alert.length > 0) {
      alert.show().animate({height: alert.outerHeight()}, 200);

      window.setTimeout(function() {
        alert.slideUp();
      }, 3000);
    }
  });
  
//////////////////////////////////////////////////////////////
  // show/hide stats panel
  $('#stats_tab').click(function() {
    $('#stats_container').toggle('slow', function() {});
    $('#stats_table').fadeIn(2000);
  });
  
//////////////////////////////////////////////////////////////
  // fade out liker avatar and fade in liker name
  $('.likers').hover(
    
    function() {
      $('img.likers_avatar').stop().fadeTo('fast', 0.5);
    },
    function() {
      $(this).stop().fadeTo('fast', 1);
    }
  
  );
  
  $('img.profile_img').hover(
    
    function() {
      $(this).stop().fadeTo('fast', 0.5);
    },
    function() {
      $(this).stop().fadeTo('fast', 1);
    }
    
  
  );
  
//////////////////////////////////////////////////////////////
  // toggle random ffflourish on landing page
  $('#show_rand_ffflourish').click(function() {
    $('#rand_ffflourish_container').slideDown(1200);
  });
  
//////////////////////////////////////////////////////////////
  // array of helpful suggestions for what to post about
  var postHelpers = new Array(
                      "Are you out in the sunshine?",
                      "Maybe you just got some invigorating exercise?",
                      "Is there something you're thankful for?",
                      "Is there someone who inspires you?",
                      "Are you preparing a healthy meal?",
                      "Did you get a restful night's sleep?",
                      "Maybe you're eating something particularly nourishing?",
                      "Maybe you're taking time for quiet?",
                      "Are you volunteering or helping others?",
                      "Are you breathing fresh air?",
                      "Maybe you're working towards a personal goal or resolution?",
                      "Do you see something beautiful?",
                      "Maybe you're eating your vegetables?",
                      "Do you wanna share a link to an interesting health-related article?"
                    );
  
  $('.active').live("click", function() {
    var helperCount = postHelpers.length;
    var position = Math.floor(Math.random() * helperCount);
    var output = postHelpers[position - 1];
    
    $(this).removeClass('active');
    $('#post_helper_answer').append(output).fadeIn(750, function() {
       $(this).delay(2500).fadeOut(1000, function() {
         $(this).empty();
         $('#post_helpers').addClass('active');
       });
    });
  });


//////////////////////////////////////////////////////////////
  // linkify for links in posts
  $('.feed_entry_text').linkify();
  $('#user_handle').linkify();

});

