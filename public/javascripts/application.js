// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){

//////////////////////////////////////////////////////////////
  // toggle post options icons
  $('#post_content').focus(function() {
    $('#posting_options').show('slow', function() {
      $('#post_options_container').show(1000);
      $('#post_fields_container').show('fast');
    });
  });

  $('img#post_image').click(function() {
    $('.post_image_fields').toggle('slow', function() {});
    $('.post_text_fields').fadeIn(2000);
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
	  $('#post_submit').click(function() {
      $('.errors').hide();
	    var postFormVal = $('#post_content').val();

	    if ( postFormVal == '' ) {
	      $('p.errors').replaceWith('<p class="errors">Oops! your post was empty.</p>').show();
        hasError = true;
        $('p.errors').fadeOut(2000);
	    }
	    else if ( postFormVal.length <= 4 ) {
	      $('p.errors').replaceWith('<p class="errors">Oops! your post was to short.</p>').slideDown(2000);
        hasError = true;
        $('p.errors').fadeOut(2000).delay(3000).slideUp(1000);
	    }
	    else if( postFormVal == postText ) {
	      $('p.errors').replaceWith('<p class="errors">That\'s what we are asking you.</p>').show();
	      hasError = true;
	      $('p.errors').fadeOut(3000).delay(2000).slideUp(1000);
	    };
      if (hasError == true) {
        hasError = false;
        return false;
      }
      else {
        return true;
      };
      
	  });
  });

  // comment form
  $(function() {
    var hasError = false;
    var commentText = $('.comment_field').val();

    $('.comment_field')
      .val(commentText)
      .focus(function() {
        if ( this.value == commentText ) this.value = ''
      })
      .blur(function() {
        if ( !$.trim( this.value ) ) this.value = commentText
      });
    
    // error handling for textarea value
    // this does not work yet, perhaps it is a unique id issue
    $('#comment_submit').click(function() {
      $('.errors').hide();
	    var postFormVal = $('#post_content').val();

	    if ( postFormVal == '' ) {
	      $('.errors').replaceWith('<p class="errors">Oops! your comment was empty.</p>');
        hasError = true;
	    }
	    else if ( postFormVal.length <= 4 ) {
	      $('p.errors').replaceWith('<p class="errors">Oops! your comment was to short.</p>').fadeIn(2000).slideDown(2000);
        hasError = true;
        $('p.errors').fadeOut(4000).delay(3000).slideUp(1000);
	    }
	    else if( postFormVal == commentText ) {
	      $('.errors').replaceWith('<p class="errors">Please provide a message.</p>');
	      hasError = true;
	    };
      if (hasError == true) {
        alert('oops!');
        hasError = false;
        return false;
      }
      else {
        return true;
      };
      
	  });
  });

//////////////////////////////////////////////////////////////
  // linkify for links in posts
  $('.content').linkify();
  $('.feed_entry_text').linkify();

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

});

