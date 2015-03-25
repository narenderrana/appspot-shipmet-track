<!DOCTYPE html>
<!--
    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
     KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.
-->
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="format-detection" content="telephone=no" />
        <meta name="msapplication-tap-highlight" content="no" />
        <!-- WARNING: for iOS 7, remove the width=device-width and height=device-height attributes. See https://issues.apache.org/jira/browse/CB-4323 -->
        <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width, height=device-height, target-densitydpi=device-dpi" />
        <link rel="stylesheet" type="text/css" href="/assets/css/bootstrap-min.css" />
        <link rel="stylesheet" type="text/css" href="/assets/css/index.css" />
        <title> </title>
        <script type="text/javascript"
          src="http://maps.google.com/maps/api/js?sensor=true&libraries=geometry">
        </script>

    </head>
    <body>
        <div id="header" class="header">
             Enter Shipment Id <input type="text" id="shipmentId" />
            <button id="btn-enabled" class="btn navbar-btn" data-id="true">Start</button>
            <button id="btn-reset" class="btn btn-default glyphicon">Reset</button>
            <button id="btn-pace" data-id="false" class="btn navbar-btn">Aggressive</button>
            <button id="btn-home" class="btn navbar-btn btn-default glyphicon glyphicon-screenshot"></button>  

        </div>
        <div id="map-canvas"></div>
        
        
<!--         <nav id="footer" class="navbar navbar-default navbar-fixed-bottom" role="navigation">
   
            
            
            
        </nav> -->


       
        <script type="text/javascript" src="/assets/js/jquery-2.1.1.js"></script>
        <script type="text/javascript" src="/assets/js/index.js"></script>
        <script>
        $(document).ready(function() {
      	  app.initialize();
        });
    /*     var  continueTrackingFlag=true;
        var timeout=3000;
      $(document).ready(function() {
    	  app.initialize();
    	  var track = function() {
    	      $.ajax({
    	    	  url:"/shipment/track/get",
    	    	  method:"GET",
    	    	  data:"shipmentid="+$('#shipmentId').val(),
    	    	  success:function(dataIn){
    	   
    	    		  app.setCurrentLocation(dataIn);
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
       */
 
 
    </script>
    </body>
</html>
