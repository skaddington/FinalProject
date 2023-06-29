package com.skilldistillery.nationalparks.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.skilldistillery.nationalparks.entities.Park;
import com.skilldistillery.nationalparks.entities.ParkComment;
import com.skilldistillery.nationalparks.entities.ParkPhoto;
import com.skilldistillery.nationalparks.entities.User;
import com.skilldistillery.nationalparks.repositories.ParkPhotoRepository;
import com.skilldistillery.nationalparks.repositories.ParkRepository;
import com.skilldistillery.nationalparks.repositories.UserRepository;

@Service
public class ParkPhotoServiceImpl implements ParkPhotoService {
	
	@Autowired
	private ParkPhotoRepository parkPhotoRepo;
	@Autowired
	private UserRepository userRepo;
	@Autowired
	private ParkRepository parkRepo;

	@Override
	public List<ParkPhoto> index() {
		return parkPhotoRepo.findAll();
	}
	
	@Override
	public List<ParkPhoto> getPicturesByParkStateName(String stateName) {
		List<ParkPhoto> parkPhoto = parkPhotoRepo.findByPark_States_Name(stateName);
		return parkPhoto;
	}

//	@Override
//	public ParkPhoto addPicture(String username, String state, String image) {
//		User managedUser = userRepo.findByUsername(username);
//		
//		
//		state.(managedUser);
//		ParkComment newParkPhoto = parkPhotoRepo.saveAndFlush(image);
//		
//		managedUser.addParkPhoto(newParkPhoto);
//		return newParkPhoto;
//	}
	
	
	
}
