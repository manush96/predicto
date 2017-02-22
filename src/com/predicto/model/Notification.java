package com.predicto.model;

public class Notification {
	private int id;
	private int user_id;
	private int type;
	private int status;
	private String pushed_when;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getPushed_when() {
		return pushed_when;
	}
	public void setPushed_when(String pushed_when) {
		this.pushed_when = pushed_when;
	}
}
