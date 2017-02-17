package com.predicto.model;


import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.*;

@SuppressWarnings("unused")
@Entity
@Table(name = "user")
public class User {

	@Id
	@GeneratedValue
	@Column(name = "id")
	private Long Id;

	public User() {
	}

	@Column(name = "username", nullable =true, length=20)
	private String userName;
	@Column(name = "email", nullable =true, length=20)
	private String email;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@Column(name = "password", nullable = true, length=20)
	private String password;

	public Long getId() {
		return Id;
	}

	public void setId(Long id) {
		Id = id;
	}

	public String getUserName() {
		return userName;
	}

	public String getPassword()
	{
			return password;
	}

	public void setPassword(String password) {
		this.password=password;        		
	}



}