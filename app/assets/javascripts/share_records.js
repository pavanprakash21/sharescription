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

    $('input.autocomplete').on('change paste keyup', function() {
      var value = $(this).val()
      if (value.length == 0) {
        clearRendered();
      }
    })

    $('#js-share-temp-revoke > i').on('click', function(){
      var id = $(this).data('id');
      $.ajax({
        url: '/share_records/' + id + '/temp_revoke',
        type: 'PATCH',
        success: function(data) {
          if (data.visible === false) {
            $('#js-share-temp-revoke > i[data-id='+ id + ']#js-visibility-filter').text('visibility_off')
          } else if (data.visible === true) {
            $('#js-share-temp-revoke > i[data-id='+ id + ']#js-visibility-filter').text('visibility')
          }
          Materialize.toast(data.message, 4000, 'toast-flash toast-success')
        },
        error: function(data) {
          Materialize.toast(data.responseJSON.message, 4000, 'toast-flash toast-error')
        }
      });
    });
});

function renderShareText(val) {
  $('#js-confirm-share-prompt-text').unbind().text('This record will be shared with ' + val.name + ' (' + val.class + '). Are you sure? You can always revoke permissions by going to the shared records tab.');
}

function renderShareButtons() {
  $('#js-confirm-share-prompt-response').unbind().append(
    '<div id="js-wrapped-append"><br/><div class="col s3"></div><div class="col s3"><div class="btn btn-floating teal"><i class="material-icons" id="js-share-confirm">check</i></div></div><div class="col s3"><div class="btn btn-floating teal"><i class="material-icons" id="js-share-cancel">cancel</i></div></div><div class="col s3"></div></div>'
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
  $('#js-confirm-share-prompt-text').children().unbind();
  $('#js-confirm-share-prompt-response').children().unbind();
  $('#js-wrapped-append').remove();
  $('#js-confirm-share-prompt-text').empty();
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
      renderToastAndCloseModal(data.message, 'success');
    },
    error: function(data) {
      renderToastAndCloseModal(data.responseJSON.message, 'error');
    }
  });
}

function renderToastAndCloseModal(data, respStatus) {
  Materialize.toast(data, 4000, 'toast-flash toast-'+ respStatus);
  $('#share-modal').modal('close');
}
