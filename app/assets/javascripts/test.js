$(document).ready(function(){
  var mapOptions = {
    center: new google.maps.LatLng(50.026786, 21.985270),
    zoom: 17,
    mapTypeControlOptions: { mapTypeIds: [] }
  }
  map = new google.maps.Map(document.getElementById("map"), mapOptions);
  service = new google.maps.places.PlacesService(map);

  //tworzymy przesuwalny marker z pewnymi parametrami domyślnymi i umieszczamy go na mapie
  marker = new google.maps.Marker({
     position: new google.maps.LatLng(50.026786, 21.985270),
     map: map,
     title: 'Przeciągnij marker na pozycję obiektu',
     draggable: true
   });

   $('#set_map').click(function(){
     set_map_pos();
   });

   //dodajemy zdarzenie do markera, aby po przesunięciu jego pozycji aktualizowane były współrzędne w formularzu
   marker.addListener('dragend', function(){
     set_coordinates();
   });

   $('#specialist_street').focusout(function(){
     set_map_pos();
   });
});

function set_coordinates(){
  $('#specialist_coordx').val(marker.getPosition().lat());
  $('#specialist_coordy').val(marker.getPosition().lng());
}

function set_map_pos(){
  var city = $('#specialist_city').val();
  var street = $('#specialist_street').val();
  var query = city + ', ' + street;
  var request = {
    query: query,
    fields: ['name', 'geometry']
  };

  service.findPlaceFromQuery(request, function(results, status) {
    if(status == google.maps.places.PlacesServiceStatus.OK) {
      map.setCenter(results[0].geometry.location);
      marker.setPosition(results[0].geometry.location);
      set_coordinates();
    }
  });
}
