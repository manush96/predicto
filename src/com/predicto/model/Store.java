package com.predicto.model;

public class Store {

	private int id;
	private String store_id;
	private String name;
	private String latitude;
	private String longitude;
	private String locality;
	private String contact;
	private String address;
	private String city;
	private String state;
	private String pincode;
	
	public Store()
	{
		
	}
	public Store(String store_id, String name, String latitude, String longitude, String locality, String contact, String address, String city, String state, String pincode)
	{
		this.store_id = store_id;
		this.name = name;
		this.name = latitude;
		this.name = longitude;
		this.name = locality;
		this.name = contact;
		this.name = address;
		this.name = city;
		this.name = state;
		this.name = pincode;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getLocality() {
		return locality;
	}
	public void setLocality(String locality) {
		this.locality = locality;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getPincode() {
		return pincode;
	}
	public void setPincode(String pincode) {
		this.pincode = pincode;
	}
	
}
