package com.skilldistillery.nationalparks.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.nationalparks.entities.ParkPhoto;

public interface ParkPhotoRepository extends JpaRepository<ParkPhoto, Integer>{
	
	ParkPhoto findById(int id);
}
