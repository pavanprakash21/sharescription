// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// Call an ajax function to get the details of the prescriptions from the medical record.
// ID of the medical record will be taken from data-id attribute of the icon.
$(document).ready(function() {
  $('#js-prescription-onclick > i').on('click', function(){
    var id = $(this).data('id');
    $.ajax({
      url: '/medical_records/' + id,
      type: 'GET',
      jsonp: 'jsonp_callback',
      dataType: 'jsonp',
    });
    $('#prescription-modal').modal();
  });
});
