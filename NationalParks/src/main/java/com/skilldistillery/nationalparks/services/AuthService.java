package com.skilldistillery.nationalparks.services;

import com.skilldistillery.nationalparks.entities.User;

public interface AuthService {

	public User register(User user);
	public User getUserByUsername(String username);
}
