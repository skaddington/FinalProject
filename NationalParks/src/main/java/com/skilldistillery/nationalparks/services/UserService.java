package com.skilldistillery.nationalparks.services;

import java.util.List;

import com.skilldistillery.nationalparks.entities.User;

public interface UserService {

	List<User> index(String username);
	User show(String username, int id);
	User update(String username, int id, User user);
	//TODO Add method if necessary for disable/enable user
	User addParkToUserFavorites(String username, int pid);
	User findByUsername(String username);
	User removeParkFromUserFavorites(String username, int pid);
	boolean disableUser(int id);
}
