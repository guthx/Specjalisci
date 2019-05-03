$(document).ready(function(){
  var input = document.getElementById('pac-input');
  var searchBox = new google.maps.places.SearchBox(input);

  searchBox.addListener('places_changed', function() {

    //zczytaj wybrane miejsca
    var places = searchBox.getPlaces();

    //jeżeli nie ma żadnych wybranych miejsc, wyjdź z funkcji
    if (places.length == 0) {
      return;
    }

    //zmienna określającą nową pozycję mapy
    var bounds = new google.maps.LatLngBounds();

    //przypisz do zmiennej pierwsze wybrane miejsce (jeśli wybrano więcej niż jedno)
    var place = places[0];

    //jeśli wybrane miejsce nie ma zakodowanych współrzędnych, wyjdź z funkcji
    if (!place.geometry) {
       console.log("Returned place contains no geometry");
       return;
    }

    $('#coordx').val(place.geometry.location.lat());
    $('#coordy').val(place.geometry.location.lng());

  });
});
