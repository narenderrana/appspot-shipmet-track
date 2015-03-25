package com.shipment.tracking.bean;



public class Shipment {
	
	private long shipmentId;
    private long timestamp;
	private double longitude;
	private double latitude;
	
	public Shipment() {
	 
	}
	public Shipment( long shipmentId ,long timestamp,double longitude,double latitude) {
		 this.shipmentId=shipmentId;
		 this.timestamp=timestamp; 
		 this.longitude=longitude;
		 this.latitude=latitude;
	}
	public long getShipmentId() {
		return shipmentId;
	}
	public void setShipmentId(long shipmentId) {
		this.shipmentId = shipmentId;
	}
    
	public long getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(long timestamp) {
		this.timestamp = timestamp;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
    public boolean isEmpty(){
    	
    	return (shipmentId<=0);
 
    }

}
