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

    var defaultText = "What are you doing right now that's healthy for you?";

    $('#post_content')
	    .val(defaultText)
	    .focus(function() {
	      if ( this.value == defaultText ) this.value = ''
	    })
	    .blur(function() {
	      if ( !$.trim( this.value ) ) this.value = defaultText
	    });

	  $('#post_submit').click(function() {

	    $('.errors').hide();
	    var postFormVal = $('#post_content').val();

	    if ( postFormVal == '' ) {
	      $('#question_field').after('<span class="error">Oops! please let us know something you are doing.</span>');
	      hasError = true;
	    }
	    else if( postFormVal == defaultText ) {
	      $('#question_field').after('<span class="error">That is what we are asking you.</span>');
	      hasError = true;
	    }

	    return flase;
	  });
  });

//////////////////////////////////////////////////////////////
  //dynamicly generated id for form fields
//  $('.hidden').hide();

//  $(function showHide(objID) {
//    if (document.getElementById(objID)) {
//      if (document.getElementById('show_comments'+objID).style.display != 'none') {
//         document.getElementById('show_comments'+objID).style.display = 'none';
//         document.getElementById(objID).style.display = 'block';
//      }
//      else {
//         document.getElementById('show_comments'+objID).style.display = 'inline';
//         document.getElementById(objID).style.display = 'none';
//      }
//   }
//  });

//  $('.comments_count').click(function(){
//    var post_id = $(this).attr("data-id");
//    $('#show_comments_'+post_id).prev('.hidden_comments').toggle('slow', function() {});
//  });
//  function showHide(objID) {
//    $('#show_comments_'+objID).hide()
//    $('#comment_count_'+objID).click(function() {
//      $('#show_comments_'+objID).toggle('slow', function() {});
//    });
//  }

//  $('.feed_entry_comments').hide()
//  $('.comment_post_link').click(function() {
//    $('.feed_entry_comments').toggle('slow', function() {});
//
//  });

//  $(function(){
//    $('a.comment_count').live('click', function() {

//      var new_id = new Date().getTime();
//      var regexp = new RegExp("new_" + association, "g")

//      $(this).parent().before(content
//    });

//  });

//////////////////////////////////////////////////////////////
  // linkify for links in posts
  $('.content').linkify();
  $('.feed_entry_text').linkify();



});

