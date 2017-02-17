package com.predicto.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.predicto.model.User;
import com.predicto.dao.user_dao;

@Service("user_services")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)

public class user_services {
private user_dao userdao;
@Autowired
public user_services(user_dao userDao) {
	this.userdao = userDao;
}


public user_services() {
}

@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
public void addUser(User user) throws Exception {
userdao.addUser(user);
}


}
