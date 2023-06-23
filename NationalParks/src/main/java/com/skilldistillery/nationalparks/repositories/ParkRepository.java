package com.skilldistillery.nationalparks.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.nationalparks.entities.Park;


public interface ParkRepository extends JpaRepository<Park, Integer> {

	Park findById(int id);
	
	//Park findByUser_Id(int id);
	
	Park findByName(String name);
}
