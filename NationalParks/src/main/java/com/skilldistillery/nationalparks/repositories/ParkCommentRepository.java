package com.skilldistillery.nationalparks.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.nationalparks.entities.ParkComment;

public interface ParkCommentRepository extends JpaRepository<ParkComment, Integer> {
	
	ParkComment findById(int id);
	List<ParkComment> findByPark_NameAndEnabledTrue(String name);
	List<ParkComment> findByPark_IdAndEnabledTrue(int parkId);
	

}
