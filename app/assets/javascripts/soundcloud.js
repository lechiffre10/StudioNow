$(document).ready(function() {
  $("button").on("click", function(event) {
    SC.initialize({
      client_id: '0ee875aff73dfd839ecb62780db4cbca'
    });
    var track_url = 'https://soundcloud.com/josh-tagaloa/jumping-in-puddles';
    SC.oEmbed(track_url, { auto_play: true }, function(response){

      $('#soundcloud').append('<p>'+response.html+'</p>');
    });



   //  soundcloud.addEventListener('onPlayerReady', function(player, data) {
   //   player.api_play();
   // });

    // SC.get('/tracks', { genres: 'rock' }, function(tracks) {
    //   $(tracks).each(function(index, track) {
    //     $('#soundcloud').append($('<li></li>').html(track.title + ' - ' + track.genre));
    //   });
    // });
  });
});
