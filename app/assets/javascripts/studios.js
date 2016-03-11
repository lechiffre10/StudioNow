var map;
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -34.397, lng: 150.644},
    zoom: 8
  });
}

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

