package com.skilldistillery.nationalparks.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.nationalparks.entities.ParkRating;

public interface ParkRatingRepository extends JpaRepository<ParkRating, Integer> {

	
}
