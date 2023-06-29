package com.skilldistillery.nationalparks.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.nationalparks.entities.Park;
import com.skilldistillery.nationalparks.entities.ParkRating;
import com.skilldistillery.nationalparks.entities.User;
import com.skilldistillery.nationalparks.repositories.ParkRatingRepository;
import com.skilldistillery.nationalparks.repositories.ParkRepository;
import com.skilldistillery.nationalparks.repositories.UserRepository;

@Service
public class ParkRatingServiceImpl implements ParkRatingService {

	@Autowired
	private ParkRatingRepository parkRatingRepo;
	@Autowired
	private ParkRepository parkRepo;
	@Autowired
	private UserRepository userRepo;
	
	@Override
	public ParkRating addParkRating(String username, int pid, ParkRating rating) {
		User loggedInUser = userRepo.findByUsername(username);
		Park selectedPark = parkRepo.findById(pid);
		rating.setUser(loggedInUser);
		rating.setPark(selectedPark);
		return parkRatingRepo.saveAndFlush(rating);
	}

}
