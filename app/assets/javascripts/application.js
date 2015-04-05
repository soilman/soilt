// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery-ui
//= require autocomplete-rails
//= require_tree .
//= require twitter/typeahead
//= require jquery-tablesorter




$( document ).ready(function() {
  $("#myTable").tablesorter();
  $('.search-query').bind('railsAutocomplete.select', function(event, data){
  $('.search-me').trigger('click');
  });
});

$(document).ready(function() {
  $('#export-button').on('click', function() {
    $('#export-form').submit();
    if ($("[id^=exports]").is(':checked')){
      $('.alert').hide();
      $('.span9').prepend('<div class="alert alert-success">Export successful</div>');
    }
    $('[id^=exports]').removeAttr('checked');

  });
});

