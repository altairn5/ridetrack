var map;
var placeSearch;
var autocomplete;
var autocompleteEnd;
var originAddress;
var destAddress;
var originLtLg = {};
var destinLtLg = {};
var originlat;
var originlng;
var destinlat;
var destinlng;
var uberServerToken = "I2ETd0X-rdy7XUihs2AkofcOG2TkfwJgYh5K3GKV";



//google maps bounds
var defaultBounds; 
defaultBounds = new google.maps.LatLngBounds(
new google.maps.LatLng(71.3867745,-66.9502861),
new google.maps.LatLng(18.9110642,172.4458955));

var options = {
  bounds: defaultBounds
};

function initAutocomplete() {
  
  autocomplete = new google.maps.places.Autocomplete((document.getElementById('autocomplete')), options);
  // google.maps.event.addListener(autocomplete, 'place_changed', function(){
  // originAddress = $("#autocomplete").val();
  // var address = originAddress.replace(" ","+");
  //  $.get("https://maps.googleapis.com/maps/api/geocode/json?", {"address" : address}, function(data){
  //    originLtLg = data.results[0].geometry.location;
    // });
  // });

  autocompleteEnd = new google.maps.places.Autocomplete((document.getElementById('autocompleteEnd')), options);
  // google.maps.event.addListener(autocompleteEnd, 'place_changed', function(){
  // destAddress = $("#autocomplete").val();
  // var address = destAddress.replace(" ","+");
  //  $.get("https://maps.googleapis.com/maps/api/geocode/json?", {"address" : address}, function(data){
  //    destinLtLg = data.results[0].geometry.location;
    // });
  // });
}
function ridetrack(){

   originAddress = $("#oAddress").data('string');
   destAddress = $("#dAddress").data('string');
    var address = originAddress.replace(" ","+");
    var endAddress = destAddress.replace(" ","+");

$.when(
       $.get("https://maps.googleapis.com/maps/api/geocode/json?", {"address" : address}, function(data){
         originLtLg = data.results[0].geometry.location;
        }),

      $.get("https://maps.googleapis.com/maps/api/geocode/json?", {"address" : endAddress}, function(data){
        destinLtLg = data.results[0].geometry.location;
      })
).then(function(){

    originlat = originLtLg.lat;
    originlng = originLtLg.lng;
    destinlat = destinLtLg.lat;
    destinlng = destinLtLg.lng;

    getEstimatesForUserLocation(originlat,originlng,destinlat,destinlng)
    

});
//end of function ridetrack
}

//Render Google Maps

function renderMap(){
var markerArray = [];
//google maps directions variable
var directionsService = new google.maps.DirectionsService;

  map = new google.maps.Map(document.getElementById("map"),{
      center:
        originLtLg,
        destinLtLg,
        zoom:13,
        zoomControl: false,
        scaleControl: false,
        scrollwheel: false,
        disableDoubleClickZoom: true
  });

  // Create a renderer for directions and bind it to the map.
  var directionsDisplay = new google.maps.DirectionsRenderer({map: map}); 

   // Instantiate an info window to hold step text.
  var stepDisplay = new google.maps.InfoWindow;

    // Display the route between the initial start and end selections.
  calculateAndDisplayRoute(
      directionsDisplay, directionsService, markerArray, stepDisplay, map);

  // Listen to change events from the start and end lists.
  var onChangeHandler = function() {
    calculateAndDisplayRoute(
        directionsDisplay, directionsService, markerArray, stepDisplay, map);
     };
  document.getElementById('oAddress').addEventListener('change', onChangeHandler);
  document.getElementById('dAddress').addEventListener('change', onChangeHandler);

}

function calculateAndDisplayRoute(directionsDisplay, directionsService,
    markerArray, stepDisplay, map) {
  // First, remove any existing markers from the map.
  for (var i = 0; i < markerArray.length; i++) {
    markerArray[i].setMap(null);
  }

  // Retrieve the start and end locations and create a DirectionsRequest using
  // WALKING directions.
  directionsService.route({
    origin: originAddress,
    destination: destAddress,
    travelMode: google.maps.TravelMode.DRIVING
  }, function(response, status) {
    // Route the directions and pass the response to a function to create
    // markers for each step.
    if (status === google.maps.DirectionsStatus.OK) {
      document.getElementById('warnings-panel').innerHTML =
          '<b>' + response.routes[0].warnings + '</b>';
      directionsDisplay.setDirections(response);
      // showSteps(response, markerArray, stepDisplay, map);
    } else {
      window.alert('Directions request failed due to ' + status);
    }
  });
 }
// function showSteps(directionResult, markerArray, stepDisplay, map) {
//   // For each step, place a marker, and add the text to the marker's infowindow.
//   // Also attach the marker to an array so we can keep track of it and remove it
//   // when calculating new routes.
//   var myRoute = directionResult.routes[0].legs[0];
//   for (var i = 0; i < myRoute.steps.length; i++) {
//     var marker = markerArray[i] = markerArray[i] || new google.maps.Marker;
//     marker.setMap(map);
//     marker.setPosition(myRoute.steps[i].start_location);
//     attachInstructionText(stepDisplay, marker, myRoute.steps[i].instructions);
//   }
// }

// function attachInstructionText(stepDisplay, marker, text, map) {
//   google.maps.event.addListener(marker, 'click', function() {
//     // Open an info window when the marker is clicked on, containing the text
//     // of the step.
//     stepDisplay.setContent(text);
//     stepDisplay.open(map, marker);
//   });
// }

   



function getEstimatesForUserLocation(olat,olng,dlat,dlng) {

  console.log("CALLING RIDE!");
  console.log("origin", originLtLg);
  console.log("destin", destinLtLg);
$.ajax({
    url: "https://api.uber.com/v1/estimates/price?",
    headers: {
        Authorization:  "Token " + uberServerToken
    },
    data: {
        start_latitude: olat,
        start_longitude: olng,
        end_latitude: dlat,
        end_longitude: dlng
    },

    success: function(result) 
    {

      console.log(result);
      //prices is an array of objects from uber API
      result.prices;

      var price = [];
      // price is now an array objects with information needed
      price = result.prices.map(function(eachObj)
      {

        var priceObj = {};
        
        priceObj["estimate"] = eachObj.high_estimate;
         priceObj["ride_name"] = eachObj.localized_display_name;

        console.log("this is priceObj: ", priceObj);

        return priceObj;

      });
      console.log("this is the price object" , price);

      //priceArray is only the price values, so they can be display in the chart            
      pricesArray = price.map(function(p){

        return p.estimate;
        
      });
      //Code below cretes the Chart line
      //for asynchronous reasons the entire code is inside the success function
            var lineChartData = {
            labels: ["UberX", "UberXL", "UberSelect", "UberBlack", "UberSUV", "Assist", "UberWAV"],
            datasets: [{
            fillColor: "rgba(220,220,220,0)",
            strokeColor: "white",
            pointColor: "rgba(220,180,0,1)",
             //priceArray is a ference only priceArray.map sets array = to data 
            data: pricesArray.map(function (price) { return price } )
            // data: dData
            }]

            }
            //displaying array indexes in console
            var dataindex = lineChartData.datasets[0].data;
            var whatsTheIndex = function(dataindex){
            for(var i = 0;i<=dataindex.length;i++){

            console.log("this index number: ", [i], dataindex[i]);
            }

            }

            Chart.defaults.global.animationSteps = 50;
            Chart.defaults.global.tooltipYPadding = 16;
            Chart.defaults.global.tooltipCornerRadius = 0;
            Chart.defaults.global.tooltipTitleFontStyle = "normal";
            Chart.defaults.global.tooltipFillColor = "rgba(0,160,0,0.8)";
            Chart.defaults.global.animationEasing = "easeOutBounce";
            Chart.defaults.global.responsive = true;
            Chart.defaults.global.scaleLineColor = "red";
            Chart.defaults.global.scaleFontSize = 16;

            var index = 11;
            var ctx = document.getElementById("canvas").getContext("2d");
            var lineChartDemo = new Chart(ctx).Line(lineChartData, {
            // responsive: true,
            // lineValueSpacing: 2
            pointDotRadius: 5,
            // bezierCurve: false,
            scaleShowVerticalLines: false,
            scaleGridLineColor: "gray"

            });
            var cost = pricesArray[1]
            var ride = price[1]["ride_name"]

            $('#ride-cost').append('<p>Cost: '+"$"+cost+".00"+'</p>')
            $('#ride-name').append('<p>Ride: '+ ride+'</p>')
            //WILL use this equation once database is setup
            // setInterval(function() {
            //   // lineChartDemo.removeData();
            //   lineChartDemo.addData([pricesArray.map(function (price) { return price } )], "dD " + index);
            //   index++;
            // }, 3000);
            whatsTheIndex(dataindex);
          
            renderMap()



      console.log("this prices array", pricesArray);



    }
  });
}


// var dData = function() {
//   return Math.round(Math.random() * 90) + 10
// }


$(document).ready(function(){

  
 
});


