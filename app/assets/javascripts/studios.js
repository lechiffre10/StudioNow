var map;

var initMap = function () {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -34.397, lng: 150.644},
    zoom: 8
  });


var infoWindow = new google.maps.InfoWindow({map: map});

if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };

      infoWindow.setPosition(pos);
      infoWindow.setContent('Location found.');
      map.setCenter(pos);
    }, function() {
      handleLocationError(true, infoWindow, map.getCenter());
    });
  } else {
    // Browser doesn't support Geolocation
    handleLocationError(false, infoWindow, map.getCenter());
  }

  function handleLocationError(browserHasGeolocation, infoWindow, pos) {
    infoWindow.setPosition(pos);
    infoWindow.setContent(browserHasGeolocation ?
                          'Error: The Geolocation service failed.' :
                          'Error: Your browser doesn\'t support geolocation.');
  }
};
$(document).ready(function() {
  initMap();

  // $("#location-search").on("submit", function(event){
  //   // event.preventDefault();
  //   var formData = $("#location-search").serialize();
  //   var request = $.ajax({
  //     method: "GET",
  //     url: "/studios",
  //     data: formData,
  //   });

  // request.done(function(response){
  //   console.log(response);
  // });

  // });



});

