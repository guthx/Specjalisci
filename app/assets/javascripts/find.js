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
  console.log(specialty_id);
  var url = "findJSON.json?id=" + specialty_id;
  $.getJSON(url, function(json){
    console.log(json);
    $.each(json, function(i, obj){
      var position2 = new google.maps.LatLng(obj.coordx, obj.coordy);
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
            $('#lista').append("<li class='specialist' distance=" + distance + " coordx=" + obj.coordx + " coordy=" + obj.coordy + " id=" + obj.id + ">" + "<div class='first_name'>Imie: " + obj.first_name + "</div><div class='last_name'>Nazwisko: " + obj.last_name + "</div><div class='location'><div class='address'>Lokacja: " + obj.city + ", " + obj.street + "</div><div class='distance'>" + distanceText + "</div></div>"
            + "<div class='rating'><div class='star-ratings-sprite'><span style='width:" + (obj.rating / 5.0)*100 + "%' class='star-ratings-sprite-rating'></span></div></div>" + "<br></li>");
            if(distance > maxDistance){
              $('#lista').children().last().css({
                display: "none"
              });
            }
        }
      });
    });
  }).fail( function(d, textStatus, error) {
        console.error("getJSON failed, status: " + textStatus + ", error: "+error)
  });

  $('#distanceSlider').change(function(){
    maxDistance = $('#distanceSlider').val() * 1000;
    filter_list();
    $('#maxDistance').html("" + maxDistance/1000 + " km")
  });

  var mapOptions = {
    center: new google.maps.LatLng(50.026786, 21.985270),
    zoom: 17,
    mapTypeControlOptions: { mapTypeIds: [] }
  }
  map = new google.maps.Map(document.getElementById("map"), mapOptions);
  marker = new google.maps.Marker({
     position: new google.maps.LatLng(50.026786, 21.985270),
     map: map
   });

   $(document).on('click', '.specialist', function(){
     $('#timeOfTransit').html('');
     var lat = $(this).attr('coordx');
     var lng = $(this).attr('coordy');
     var endpoint = new google.maps.LatLng(lat, lng);
     if( $('.active').attr('id') == 'transitDriving' ){
       travelMode = 'DRIVING';
     } else if ( $('.active').attr('id') == 'transitWalking' ){
       travelMode = 'WALKING';
     }
     marker.setPosition(endpoint);
     map.setCenter(endpoint);
     directionsDisplay.set('directions', null);
     $('#drawRoute').off();
     $('#drawRoute').click(function(){
       draw_route(endpoint, travelMode);
     });
     $('#specialistDetails').css({
       display: 'block'
     });
     $('#specialistID').html($(this).attr('id'));
     link = '<a href="/reviews/new?specialist_id=' + $('#specialistID').html() + "&user_id=" + $('#currentUserID').html()  + '">Wystaw recenzję</a>';
     $('#giveReview').html(link);
     displayReviews($('#specialistID').html());
   });

   $('.transitOption').click(function(){
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
