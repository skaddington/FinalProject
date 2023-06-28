package com.skilldistillery.nationalparks.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.skilldistillery.nationalparks.entities.ParkPhoto;
import com.skilldistillery.nationalparks.repositories.ParkPhotoRepository;

@Service
public class ParkPhotoServiceImpl implements ParkPhotoService {
	
	@Autowired
	private ParkPhotoRepository parkPhotoRepo;

	@Override
	public List<ParkPhoto> index() {
		return parkPhotoRepo.findAll();
	}
	
	@Override
	public List<ParkPhoto> getPicturesByPark_State_Name(String stateName) {
		List<ParkPhoto> parkPhoto = parkPhotoRepo.findByPark_States_Name(stateName);
		return parkPhoto;
	}
	
}
