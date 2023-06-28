package com.skilldistillery.nationalparks.services;

import java.util.List;

import com.skilldistillery.nationalparks.entities.ParkPhoto;

public interface ParkPhotoService {
	
	public List<ParkPhoto> index();
	
	public List<ParkPhoto> getPicturesByPark_State_Name(String state);

}
