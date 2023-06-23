package com.skilldistillery.nationalparks.services;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.nationalparks.entities.Park;
import com.skilldistillery.nationalparks.repositories.ParkRepository;

@Service
//@Transactional
public class ParkServiceImpl implements ParkService {
	
	@Autowired
	private ParkRepository parkRepo;

	@Override
	public List<Park> index() {
		return parkRepo.findAll();
	}

	@Override
	public Park show(int id) {
		return parkRepo.findById(id);
	}

	@Override
	public Park updatePark(int pid, Park park) {
		Park existingPark = parkRepo.findById(pid);
		if(existingPark != null) {
			if (park.getDescription() != null) {
				existingPark.setDescription(park.getDescription());
			}
			if (park.getImage() != null) {
				existingPark.setImage(park.getImage());
			}
			if (park.getWebsite() != null) {
				existingPark.setWebsite(park.getWebsite());
			}
			return parkRepo.saveAndFlush(existingPark);
			
		}
		return null;
	}

}
