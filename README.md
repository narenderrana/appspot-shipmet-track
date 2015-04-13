
#Shipment Tracking Google clude code.
 
 
__1.Create account on https://cloud.google.com/appengine/__

__2.Use https://cloud.google.com/appengine/docs/java/gettingstarted/introduction step by stem to deploy code on google app engin.__

__3.Use your admin console to go to your home page.You can manage you database from this console.Currently this demo application use cloude datastore which is a Memcahed based NoSQL database.__

__4.API__

  __API to add geolocation of a device into database__
 
 __GET    /shipment/track/add__
 
 params 
    shipmentId
    timestamp
    longitude
    latitude
 
__POST /shipment/track/add__

 request body
 {location:{latitude:1212312,longitude:232132,speed:212,bearing:121,altitude:121,recorded_at:23213}}
 
 __5.API to get store geolocation of a device.__
   
   __GET /shipment/track/get__
   
   parameter 
        shipmentId
   
   
