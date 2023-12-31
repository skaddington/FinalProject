package com.skilldistillery.nationalparks.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.nationalparks.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	User findById(int id);
	User findByUsername(String username);
}
