package com.skilldistillery.nationalparks.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public List<ParkPhoto> filterOptions(String keyword) {
		// TODO Auto-generated method stub
		return null;
	}
}
