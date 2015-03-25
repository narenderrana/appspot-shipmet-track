package com.shipment.tracking.app;

 

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.SortDirection;
import com.google.gson.Gson;
import com.shipment.tracking.bean.Shipment;

public class GetShipmentGeoLocationController extends HttpServlet {
  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long count=0;

@Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
          {
	try{       
	            Shipment shipment=new Shipment();
	            response.setContentType("application/json");
	            DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	            Key geoLocation = KeyFactory.createKey("GeoLocation", "geoLocation");
	            Query query = new Query("Shipment",geoLocation)
                .addSort("timestamp", SortDirection.DESCENDING)
                .setFilter(Query.FilterOperator.EQUAL.of("shipmentId", Long.parseLong(request.getParameter("shipmentid"))));
     
                //System.out.println(query);
                
	            PreparedQuery pq = datastore.prepare(query);
	            List<Entity>  entityList =pq.asList(FetchOptions.Builder.withLimit(1));
	            //System.out.println(entityList.size());
	            if(entityList!=null&& entityList.size()>0){
	            	Entity entity=entityList.get(0);
	            	shipment= new Shipment( 
	            			Long.parseLong(entity.getProperty("shipmentId").toString()), 
	            			Long.parseLong(entity.getProperty("timestamp").toString()),
	            			Double.parseDouble(entity.getProperty("longitude").toString()),
	            			Double.parseDouble(entity.getProperty("latitude").toString()));
	            }
	          
	          if(shipment.isEmpty()){
	          //some hard coded values	  
	           shipment.setTimestamp(new Date().getTime());
	           shipment.setShipmentId(84368247);
	           shipment.setLatitude(-0.1276250+((count++)/100));
	           shipment.setLongitude(51.5033630+((count++)/100));
	           }
	  	       response.getWriter().append(new Gson().toJson(shipment, Shipment.class).toString());
	}catch(Exception exp){
		    try {
				response.getWriter().append("{\"msg\":\""+exp.getMessage()+"\"}");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
			}
	}
	    
	    
  }
@Override
public void doPost(HttpServletRequest request, HttpServletResponse response)  throws IOException {
	 
	doGet(  request,   response);
}
}