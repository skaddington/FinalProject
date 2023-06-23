package com.skilldistillery.nationalparks.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.nationalparks.entities.Park;
import com.skilldistillery.nationalparks.entities.State;
import com.skilldistillery.nationalparks.repositories.ParkRepository;
import com.skilldistillery.nationalparks.repositories.StateRepository;

@Service
public class ParkServiceImpl implements ParkService {
	
	@Autowired
	private ParkRepository parkRepo;
	
	@Autowired
	private StateRepository stateRepo;

	@Override
	public List<Park> index() {
		return parkRepo.findAll();
	}
	
	@Override 
	public List<State> stateIndex() {
		return stateRepo.findAll();
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

	@Override
	public List<Park> findByState(String name) {
		State existingState = stateRepo.findByName(name);
		if(existingState.getParks().size() > 0) {
			return existingState.getParks();
		}
		return null;
	}

}
