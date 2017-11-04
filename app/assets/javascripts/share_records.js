// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
    $('#js-share-onclick > i').on('click', function() {
      var medicalRecordId = $(this).data('id')
      $.ajax({
        url: '/search/suggestions',
        type: 'GET',
        success: function(data) {
          $('input.autocomplete').autocomplete({
            data: data,
            limit: 20,
            onAutocomplete: function(val) {
              renderAndShare(val, medicalRecordId);
            }
          });
        }
      });
      $('#share-modal').modal({dismissible: false});
    });
    $('#js-close-modal').on('click', function() {
      $('#share-modal').modal('close');
    });
});

function renderShareText(val) {
  $('#js-confirm-share-prompt-text').text('This record will be shared with ' + val.name + ' (' + val.class + '). Are you sure? You can always revoke permissions by going to the shared records tab.');
}

function renderShareButtons() {
  $('#js-confirm-share-prompt-response').append(
    '<br/><div class="col s3"></div><div class="col s3"><div class="btn btn-floating teal"><i class="material-icons" id="js-share-confirm">check</i></div></div><div class="col s3"><div class="btn btn-floating teal"><i class="material-icons" id="js-share-cancel">cancel</i></div></div><div class="col s3"></div>'
  );
}

function renderAndShare(val, medicalRecordId) {
  renderShareText(val);
  renderShareButtons();
  $('#js-share-confirm').on('click', function() {
    postShareData(val, medicalRecordId)
  });
  $('#js-share-cancel').on('click', function() {
    clearRendered();
  })
}

function clearRendered() {
  $('#js-confirm-share-prompt-text').empty();
  $('#js-confirm-share-prompt-response').empty();
  $('input.autocomplete').val('');
}

function postShareData(val, medicalRecordId) {
  $.ajax({
    url: '/share_records',
    type: 'POST',
    data: {
      share_record: {
        medical_record_id: medicalRecordId,
        shareable_id: val.id,
        shareable_type: val.class
      }
    },
    success: function(data) {
      renderToastAndCloseModal(data);
    },
    error: function(data) {
      renderToastAndCloseModal(data);
    }
  });
}

function renderToastAndCloseModal(data) {
  Materialize.toast(data.message, 4000);
  $('#share-modal').modal('close');
}
