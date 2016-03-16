$(document).ready(function() {
  var link = $('#soundcloud').find('a')
  $(link).on("click", function(event) {
    event.preventDefault();
    SC.initialize({
      client_id: '0ee875aff73dfd839ecb62780db4cbca'
    });
    var track_url = $('#soundcloud').find('a').attr('href');
    SC.oEmbed(track_url, { auto_play: true }, function(response){
      var divCount = $('#soundcloud').children().length;
      if (divCount <= 2 ) {
        $('#soundcloud').append('<p>'+response.html+'</p>');
      } else {
        $('#soundcloud').find('p').remove();
      }
    });
  });
});
