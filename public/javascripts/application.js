// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
  //$('#tab-container').easytabs();

//posting options dialog
//  $('.post_text_fields').hide();
//  $('.post_image_fields').hide();

  $('#post_content').focus(function() {
    $('#posting_options').show('slow', function() {
      $('#post_options_container').show(1000);
      $('#post_fields_container').show('slow');
    });
  });

  $('img#post_text').click(function() {
    $('.post_text_fields').toggle('slow');
  });

  $('img#post_image').click(function() {
    $('.post_image_fields').toggle('slow', function() {});
    $('.post_text_fields').fadeIn(2000);
  });

  //textarea countdown function
  $('textarea').keyup(function(){
    if(this.value.length >= 240) {
      //handle the over the limit part here
      $(this).addClass('overlimit');
      this.value = this.value.substring(0, 240);
    } else {
      $(this).removeClass('overlimit');
    }
    $('#counter').text(240-this.value.length);
  });

  //onblur and onfocus functions

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
  });

//  $('#file_upload').uploadify({
//    'uploader'  : '/uploadify/uploadify.swf',
//    'script'    : '/uploadify/uploadify.php',
//    'cancelImg' : '/uploadify/cancel.png',
//    'folder'    : '/uploads',
//    'auto'      : true
//  });
  
  $('.content').linkify();
  $('#post_body').linkify(); 

});

