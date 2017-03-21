package com.predicto.model;

public class food_details {
	int id;
	int category_id;
	String name;
	String quantity;
	float calories;
	float fat;
	float cholesterol;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCategory_id() {
		return category_id;
	}
	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	public float getCalories() {
		return calories;
	}
	public void setCalories(float calories) {
		this.calories = calories;
	}
	public float getFat() {
		return fat;
	}
	public void setFat(float fat) {
		this.fat = fat;
	}
	public float getCholesterol() {
		return cholesterol;
	}
	public void setCholesterol(float cholesterol) {
		this.cholesterol = cholesterol;
	}
	

}