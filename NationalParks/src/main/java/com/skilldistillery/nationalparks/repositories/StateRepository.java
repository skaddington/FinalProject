package com.skilldistillery.nationalparks.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.nationalparks.entities.State;

public interface StateRepository extends JpaRepository <State, Integer>{
	State findByName(String name);
	
	
}
