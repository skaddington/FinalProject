package com.skilldistillery.nationalparks.services;

import com.skilldistillery.nationalparks.entities.ParkRating;

public interface ParkRatingService {
	
	public ParkRating addParkRating(String username, int pid, ParkRating rating);

}
