// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
    $('#js-share-onclick > i').on('click', function() {
      $.ajax({
        url: '/search/suggestions',
        type: 'GET',
        success: function(data) {
          console.log(data);
          $('input.autocomplete').autocomplete({
            data: data,
            limit: 20,
            onAutocomplete: function(val) {
              console.log(val);
              $('#js-confirm-share-prompt-text').text('This record will be shared with ' + val.name + ' (' + val.class + '). Are you sure? You can always revoke permissions by going to the shared records tab.');
              $('#js-confirm-share-prompt-response').append(
                '<br/><div class="col s3"></div><div class="col s3"><div class="btn btn-floating teal"><i class="material-icons" id="js-share-confirm">check</i></div></div><div class="col s3"><div class="btn btn-floating teal"><i class="material-icons" id="js-share-cancel">cancel</i></div></div><div class="col s3"></div>'
              );
              $('#js-share-confirm').on('click', function() {
                $.ajax({
                  url: '/share_records',
                  type: 'POST',
                  body: {
                    
                  }
                  success: function(data) {
                    console.log('Shared!');
                    console.log(data);
                  }
                })
              });
              // Share with that person
              // $.ajax({
              //   url: '',
              //   type: 'GET',
              //   success: function(data) {
              //     console.log(data);
              //   }
              // })
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
