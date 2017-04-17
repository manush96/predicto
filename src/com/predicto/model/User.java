package com.predicto.model;

public class User {
	
	private int id;
	private String username;
	private String password;
	private String email;
	private int age;
	private int height;
	private int weight;
	private int gender;
	private int diabetic;
	private int smoker;
	private int alcoholic;
	private String heredity;
	private int status;
	private int burn_goal;
	private int intake_goal;
	private String blood_group;
	private int donate;
	
	public int getBurn_goal() {
		return burn_goal;
	}
	public void setBurn_goal(int burn_goal) {
		this.burn_goal = burn_goal;
	}
	public int getIntake_goal() {
		return intake_goal;
	}
	public void setIntake_goal(int intake_goal) {
		this.intake_goal = intake_goal;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	public int getWeight() {
		return weight;
	}
	public void setWeight(int weight) {
		this.weight = weight;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public int getDiabetic() {
		return diabetic;
	}
	public void setDiabetic(int diabetic) {
		this.diabetic = diabetic;
	}
	public int getSmoker() {
		return smoker;
	}
	public void setSmoker(int smoker) {
		this.smoker = smoker;
	}
	public int getAlcoholic() {
		return alcoholic;
	}
	public void setAlcoholic(int alcoholic) {
		this.alcoholic = alcoholic;
	}
	public String getHeredity() {
		return heredity;
	}
	public void setHeredity(String heredity) {
		this.heredity = heredity;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getBlood_group() {
		return blood_group;
	}
	public void setBlood_group(String blood_group) {
		this.blood_group = blood_group;
	}
	public int getDonate() {
		return donate;
	}
	public void setDonate(int donate) {
		this.donate = donate;
	}
	
}
