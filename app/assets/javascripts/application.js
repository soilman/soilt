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
  $(".myTable").tablesorter();
  $('.search-query').bind('railsAutocomplete.select', function(event, data){
  $('.search-me').trigger('click');
  });

  // $('.report-submit').on('click', function(e) {
  //   var plates = $(".modal").data('plates');
  //   var plate_value = $('#manifest_report_plate').val()
  //   if ( $.inArray(plate_value, plates) == -1 ){
  //     e.preventDefault();
  //     e.stopPropagation();
  //     $('.modal-footer.manifest-report').empty();
  //     $('.modal-footer.manifest-report').show();
  //     $('.modal-footer.manifest-report').append("Plate not found. Please try again.");
  //     $('.modal-footer.manifest-report').fadeOut(2000);
  //   }
  // });

  $('#export_button').on('click', function(e) {
    $('#export_modal').modal('hide');
  });

  var originalButtonText = $('.job-complete-button').val();

  $('.job-complete-button').hover(function() {
    $(this).val("Toggle Status");
    $(this).addClass("grey-button");
  });

  $('.job-complete-button').mouseleave(function() {
    if ( !$(this).is(":focus") ) {
      $(this).val(originalButtonText);
      $(this).removeClass("grey-button");
    }
  });
});

// $(document).ready(function() {
//   $('#export-button').on('click', function() {
//     $('#export-form').submit();
//     if ($("[id^=exports]").is(':checked')){
//       $('.alert').hide();
//       $('.span9').prepend('<div class="alert alert-success">Export successful</div>');
//     }
//     $('[id^=exports]').removeAttr('checked');

//   });
// });

