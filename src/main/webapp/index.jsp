<!-- <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/
1.4.2/jquery.min.js"></script>
<script type="text/javascript" src="jquery.cookie.js"></script>
<script type="text/javascript">
function success(position) 
{
var s = document.querySelector('#status');
if (s.className == 'success') 
{
return;
}
s.innerHTML = "Found you!";
s.className = 'Success';
var mapcanvas = document.createElement('div');
mapcanvas.id = 'mapcanvas';
mapcanvas.style.height = '100%';
mapcanvas.style.width = '100%';
document.querySelector('#map').appendChild(mapcanvas);
var latlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
var myOptions = {
zoom: 15,
center: latlng,
mapTypeControl: false,
navigationControlOptions: {style: google.maps.NavigationControlStyle.SMALL},
mapTypeId: google.maps.MapTypeId.ROADMAP
};
var map = new google.maps.Map(document.getElementById("mapcanvas"), myOptions);
var marker = new google.maps.Marker({
position: latlng, 
map: map, 
title:"You are here!"
});
$.cookie("MyLat", position.coords.latitude); // Storing latitude value
$.cookie("MyLon", position.coords.longitude); // Storing longitude value
}
function error(msg) 
{
var s = document.querySelector('#status');
s.innerHTML = typeof msg == 'string' ? msg : "failed";
s.className = 'Fail';
}
if (navigator.geolocation) 
{
navigator.geolocation.getCurrentPosition(success, error);
} 
else
{
error('Not supported'); //HTML Support
}

//Jquery Code 
$(document).ready(function()
{
$("#check").click(function()
{
var lat = $.cookie("MyLat");
var lon = $.cookie("MyLon");
alert('Latitued: '+lat);
alert('Longitude: '+lon);
var url="http://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lon+"&sensor=false";
alert('Google Map API: '+url);
//Get Json Request Here
});
});
</script>
//HTML Code
<input type='button' id='check' value='Check-out'/>
<div id="status">Loading.............</div>
<div id="map"></div>
 -->
 <!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Create a polyline using Geolocation and Google Maps API</title>
    <script src="http://maps.google.com/maps/api/js?sensor=true"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script>
    // Save the positions' history
    var path = [];
    var timeout = 5000;
    var  continueTrackingFlag=true;
    var map;
    var latLngBounds;
    var polyline ;
      $(document).ready(function() {
          // Create the map
          var myOptions = {
/*             zoom : 10, */
         /*    center : path[0], */
            mapTypeId : google.maps.MapTypeId.ROADMAP
          }
          map = new google.maps.Map(document.getElementById("map"), myOptions);
          latLngBounds= new google.maps.LatLngBounds();
          polyline = new google.maps.Polyline({
              map: map,
              path: path,
              strokeColor: '#0000FF',
              strokeOpacity: 0.7,
              strokeWeight: 1
            });  
/*     	  var myLine = new google.maps.Polyline({
    	      map: map,
    	      geodesic: true
    	    });
    	   */
 /*    	    google.maps.event.addListener(map, 'click', function(event) {
    	      new google.maps.Marker({map:map,position:event.latLng});
    	      path.push(event.latLng);
    	      myLine.setPath(path);
    	    }); */
          
          
    	  var track = function() {
    	      $.ajax({
    	    	  url:"/shipment/track/get",
    	    	  method:"GET",
    	    	  data:"shipmentid="+$('#shipmentId').val(),
    	    	  success:function(dataIn){
    	    		  console.log(dataIn);
    	    		  path.push(
    	    	              new google.maps.LatLng(
    	    	            		  dataIn.latitude,
    	    	            		  dataIn.longitude
    	    	              )
    	    	            );
    	    		  polyline.setPath(path);
    	    	  },
    	    	  error:function(errorIn){
    	    		  console.log(errorIn);
    	    	  }
    	      }); 
    	      
    	      if(continueTrackingFlag){
    	         setTimeout(track, timeout);
    	      }
    	  };
    	 track();
    	 

         
   
      });
      
      function stopTracking(){
    	  continueTrackingFlag=false;
      }
      
      function watchPosition(position) {
    	  console.log('watch postion...');
          // Save the current position
         // path.push(new google.maps.LatLng(position.coords.latitude, position.coords.longitude));
          // Create the array that will be used to fit the view to the points range and
          // place the markers to the polyline's points
          
          for(var i = 0; i < path.length; i++) {
            latLngBounds.extend(path[i]);
            // Place the marker
             new google.maps.Marker({
              map: map,
              position: path[i],
              title: "Point " + (i + 1)
            });  
          }
          // Creates the polyline object
/*            var polyline = new google.maps.Polyline({
            map: map,
            path: path,
            strokeColor: '#0000FF',
            strokeOpacity: 0.7,
            strokeWeight: 1
          });   */
          polyline.setPath(path);
  
/*           var polyline= new google.maps.Polyline({
    	      map: map,
    	      strokeColor: '#0000FF',
    	      geodesic: true
    	    }); */
          // Fit the bounds of the generated points
          map.fitBounds(latLngBounds);
        }

       function startTracking(){
           // If the browser supports the Geolocation API
           if (typeof navigator.geolocation == "undefined") {
             $("#error").text("Your browser doesn't support the Geolocation API");
             return;
           }
     	  //$('#map').html('');
     	 continueTrackingFlag=true;
     	 
           navigator.geolocation.watchPosition(watchPosition,
             function(positionError){
               $("#error").append("Error: " + positionError.message + "<br />");
             },
             {
               enableHighAccuracy: true,
               timeout: 10 * 1000 // 10 seconds
             }); 
     	  
       }  
    </script>
    <style type="text/css">
       #map {
       
        height: 800px;
        margin-top: 10px;
      } 
    </style>
  </head>
  <body>
    <h1>Shipment Tracking  </h1>
    Enter User Id <input type="text" id="shipmentId" /> <button onclick="startTracking()" >Start Tracking</button> <button onclick="stopTracking()">Stop Tracking</button>
    <div id="map"   ></div>
    <p id="error"></p>
  </body>
</html>