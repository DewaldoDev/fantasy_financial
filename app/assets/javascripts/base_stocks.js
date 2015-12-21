// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
    $('.per-change').each(function(){
      var number = parseFloat($(this).text())
      var color = '';
      if (!isNaN(number)) {
          if (number < 0) {
              color = 'red';
          }
          if (number > 0) {
              color = 'green';
          }
          $(this).css('color', color);
      }
    });
})
