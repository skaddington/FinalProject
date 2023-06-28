package com.skilldistillery.nationalparks.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.nationalparks.entities.ParkPhoto;

public interface ParkPhotoRepository extends JpaRepository<ParkPhoto, Integer>{
	
	ParkPhoto findById(int id);
	
	List<ParkPhoto> findByPark_States_Name(String state);
	
	//@Query("SELECT p FROM Park p WHERE p.state.name = :stateName")
   // List<ParkPhoto> findByParkStateName(@Param("stateName") String stateName);
}
