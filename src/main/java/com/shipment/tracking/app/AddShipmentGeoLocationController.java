package com.shipment.tracking.app;

 

import java.io.IOException;
import java.util.Date;
import java.util.Scanner;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.gson.Gson;
import com.shipment.tracking.bean.Location;
import com.shipment.tracking.bean.Shipment;

public class AddShipmentGeoLocationController extends HttpServlet {
  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

@Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws IOException {
	 System.out.println("Get requested tracked");
	response.setContentType("application/json");
	Shipment shipment=new Shipment();
    if (fecthParams(request, shipment)) {
        Key geoLocation = KeyFactory.createKey("GeoLocation", "geoLocation");
        Entity shipmentEntity = new Entity("Shipment", geoLocation);
        if (shipment != null) {
        	shipmentEntity.setProperty("shipmentId", shipment.getShipmentId());
        	shipmentEntity.setProperty("timestamp", shipment.getTimestamp());
        	shipmentEntity.setProperty("longitude", shipment.getLongitude());
        	shipmentEntity.setProperty("latitude", shipment.getLatitude());
        }
 
        DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
        datastore.put(shipmentEntity);
        //System.out.println(shipmentEntity);
        response.setContentType("application/json");
        response.getWriter().append(new Gson().toJson(shipment, Shipment.class).toString()); 
    
    } else{
    	response.getWriter().append("{\"msg\":\"Please provide all params\"}");
    	
    }
    
    /*else {
      UserService userService = UserServiceFactory.getUserService();
      User currentUser = userService.getCurrentUser();

      if (currentUser != null) {
    	  response.setContentType("text/plain");
    	  response.getWriter().println("Hello, " + currentUser.getNickname());
      } else {
    	  response.sendRedirect(userService.createLoginURL(request.getRequestURI()));
      }
    } */
	
	
	
  }

@Override
public void doPost(HttpServletRequest request, HttpServletResponse response)  throws IOException{
	    System.out.println("Post requested tracked");
	    StringBuilder stringBuilder = new StringBuilder(1000);
	    Scanner scanner = new Scanner(request.getInputStream());
	    while (scanner.hasNextLine()) {
	        stringBuilder.append(scanner.nextLine());
	    }
	    String body = stringBuilder.toString();
	    Location shipment=new Gson().fromJson(body, Location.class);
	    request.setAttribute("latitude", shipment.getLocation().getLatitude());
	    request.setAttribute("longitude", shipment.getLocation().getLongitude());
	    doGet(  request,   response);
}

private boolean fecthParams(HttpServletRequest request,Shipment shipment){
	try {
		shipment.setTimestamp(new Date().getTime());
		shipment.setShipmentId(Long.parseLong(request.getParameter("shipmentid")));
		shipment.setLatitude(Double.parseDouble(request.getParameter("latitude")!=null?request.getParameter("latitude"):request.getAttribute("latitude").toString()));
		shipment.setLongitude(Double.parseDouble(request.getParameter("longitude")!=null?request.getParameter("longitude"):request.getAttribute("longitude").toString()));
	
	} catch (Exception e) {
		e.printStackTrace();
		 return false;
	}
	
	return true;
}

public static void main(String[] args) {
	Location shipment=new Gson().fromJson("{\"location\":{\"latitude\":\"1212312\",\"longitude\":\"232132\",\"speed\":\"212\",\"bearing\":\"121\",\"altitude\":\"121\",\"recorded_at\":\"23213\"}}", Location.class);
	System.out.println("Shipment"+shipment.getLocation());
}
}