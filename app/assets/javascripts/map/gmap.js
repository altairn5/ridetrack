var map;
var placeSearch;
var autocomplete;
var originAddress;
var destAddress;

var defaultBounds; 
defaultBounds = new google.maps.LatLngBounds(
new google.maps.LatLng(71.3867745,-66.9502861),
new google.maps.LatLng(18.9110642,172.4458955));

var options = {
	bounds: defaultBounds
};

function initAutocomplete() {
  
  autocomplete = new google.maps.places.Autocomplete((document.getElementById('autocomplete')), options);

}