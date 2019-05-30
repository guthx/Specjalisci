var travelMode;
$(document).ready(function(){
  directionsDisplay = new google.maps.DirectionsRenderer();
  directionsService = new google.maps.DirectionsService();
  var coordx = $('#coordx').html();
  var coordy = $('#coordy').html();
  var specialty_id = $('#specialty_id').html();
  position = new google.maps.LatLng(coordx, coordy);
  var distanceService = new google.maps.DistanceMatrixService();
  maxDistance = 5000;
  distance_array = [];
  distance_text_array = [];
  $(".specialist").each(function(){
      var posx = $(this).attr('coordx');
      var posy = $(this).attr('coordy');
      var position2 = new google.maps.LatLng(posx, posy);
      distanceService.getDistanceMatrix({
        origins: [position],
        destinations: [position2],
        travelMode: google.maps.TravelMode.WALKING,
        unitSystem: google.maps.UnitSystem.METRIC
      },
      function (response, status) {
        if (status !== google.maps.DistanceMatrixStatus.OK) {
            console.log('Error:', status);
        } else {
            distance = response.rows[0].elements[0].distance.value;
            distanceText = response.rows[0].elements[0].distance.text;
            distance_array.push(distance);
            distance_text_array.push(distanceText);
            if (distance_array.length == $(".specialist").length){
              set_distances();
            }
        }
      });
    });

  $('#distanceSlider').change(function(){
    maxDistance = $('#distanceSlider').val() * 1000;
    filter_list();
    $('#maxDistance').html("" + maxDistance/1000 + " km")
  });



   $(document).on('click', '.specialist', function(){
  //   $('#specialistID').html($(this).attr('id'));
  //   link = '<a href="/reviews/new?specialist_id=' + $('#specialistID').html() + "&user_id=" + $('#currentUserID').html()  + '">Wystaw recenzję</a>';
  //   $('#giveReview').html(link);
  //   displayReviews($('#specialistID').html());
   });

   $(document).on('click', '.transitOption', function(){
     if(!$(this).hasClass('active')){
       $(this).addClass('active');
       $(this).siblings().removeClass('active');
       if( $('.active').attr('id') == 'transitDriving' ){
         travelMode = 'DRIVING';
       } else if ( $('.active').attr('id') == 'transitWalking' ){
         travelMode = 'WALKING';
       }
     }
   });
});

function filter_list(){
  $('#lista').children().each(function(){
    if( $(this).attr('distance') > maxDistance ) {
      $(this).css({
        display: "none"
      });
    } else {
      $(this).css({
        display: "block"
      });
    }
  });
}

function draw_route(endpoint, travelMode){
  var start = position
  var end = endpoint
  var timeOfTransit;
  //ustawienie kamery, aby obejmowała całą drogę
  var bounds = new google.maps.LatLngBounds();
  bounds.extend(start);
  bounds.extend(end);
  map.fitBounds(bounds);

  //stworzenie zapytania o wyznaczenie drogi dla zadanych puntków
  var request = {
      origin: start,
      destination: end,
      travelMode: travelMode
  };

  //wysłanie zapytania do usługi directionsService
  directionsService.route(request, function (response, status) {

      //jeśli poprawnie wyznaczono drogę, wyświetl ją na mpaie
      if (status == google.maps.DirectionsStatus.OK) {
          console.log(response);
          directionsDisplay.setDirections(response);
          directionsDisplay.setMap(map);
          timeOfTransit = response.routes[0].legs[0].duration.text;
          $('#timeOfTransit').html('Przewidywany czas dotarcia: ' + timeOfTransit);
      //jeśli nie wyznaczono drogi, zwróć ostrzeżenie
      } else {
          alert("Wystąpił błąd podczas wyznaczania trasy");
      }
  });

}


function displayReviews(specialistID){
  $('#reviews').html('');
  var url = specialistID+"/getReviews.json"
  $.getJSON(url, function(json){
    $.each(json, function(i, obj){
      $('#reviews').append('<div class="review"><div class="reviewerName">' + obj.userName + "</div>"
      + "<div class='rating'><div class='star-ratings-sprite'><span style='width:" + (obj.rating / 5.0)*100 + "%' class='star-ratings-sprite-rating'></span></div></div>"
      + "<div class='reviewText'>" + obj.text + "</div></div>");
    });
  });
}

function set_distances(){
  var i=0;
  $('.specialist').each(function(){
    var spec = $(this);
    distance = distance_array[i];
    distanceText = distance_text_array[i];
    if (distance > 50000){
      spec.remove();
    } else {
      spec.attr('distance', distance);
      spec.children('a').children('.location').children('.distance').html(distanceText);
      if(distance <= maxDistance) {
        spec.show();
      }
    }
    i = i+1;
  });

}
