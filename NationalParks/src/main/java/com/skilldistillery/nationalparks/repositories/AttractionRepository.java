package com.skilldistillery.nationalparks.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.nationalparks.entities.Attraction;

public interface AttractionRepository extends JpaRepository<Attraction, Integer> {
	
	Attraction findById(int attrId);
	Attraction findByName(String name);
	List<Attraction> findByPark_Id(int parkId);
}
