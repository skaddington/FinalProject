package com.skilldistillery.nationalparks.services;

import java.util.List;

import com.skilldistillery.nationalparks.entities.Park;

public interface ParkService {
	
	public List<Park> index();
	
	public Park show(int id);
	
	public Park updatePark(int id, Park park);

}
