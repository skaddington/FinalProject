package com.skilldistillery.nationalparks.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.nationalparks.entities.ParkPhoto;
import com.skilldistillery.nationalparks.services.ParkPhotoService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost/"})
public class ParkPhotoController {
	
	@Autowired
	private ParkPhotoService parkPhotoService;
	
	@GetMapping("gallery")
	public List<ParkPhoto> index(HttpServletRequest req, HttpServletResponse res) {
		return parkPhotoService.index();
	}
	
	@GetMapping("gallery/{pid}")
	public List<ParkPhoto> filterByState(@RequestParam String keyword) {
		List<ParkPhoto> filter = parkPhotoService.filterOptions(keyword);
		return filter;
	}
}
