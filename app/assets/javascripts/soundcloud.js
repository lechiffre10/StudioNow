$(document).ready(function() {
  var link = $('#soundcloud').find('a');
  $(link).on("click", function(event) {
    event.preventDefault();
    SC.initialize({
      client_id: '0ee875aff73dfd839ecb62780db4cbca'
    });
    var track_url = 'https://soundcloud.com/subpop/kristin-kontrol-x-communicate';
    SC.oEmbed(track_url, { auto_play: true }, function(response){
      var divCount = $('#soundcloud').children().length;
      if (divCount <= 2 ) {
        $('#soundcloud').append('<p>'+response.html+'</p>');
      } else {
        $('#soundcloud').find('p').remove();
      }
    });
  });
  $("#rating").on("click", function() {
    var userId = JSON.stringify($(".content").data("user-id"));
    var originalHTMLArray = $('.lead').html().match(/[a-zA-Z|\s|<|>|:\/]*: <\/strong>/);
    $.ajax({
      method: 'GET',
      url: "/find_average/" + userId
    }).done(function(response) {
      $('.lead').replaceWith("<h3 class='lead'>" +originalHTMLArray + response + "</h3>")
      });
  });
});
