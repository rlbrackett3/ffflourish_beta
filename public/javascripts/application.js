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

});
