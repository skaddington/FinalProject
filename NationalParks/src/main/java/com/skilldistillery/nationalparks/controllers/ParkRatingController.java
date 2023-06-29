package com.skilldistillery.nationalparks.controllers;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.nationalparks.entities.ParkRating;
import com.skilldistillery.nationalparks.services.ParkRatingService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost/"})
public class ParkRatingController {
	
	@Autowired
	private ParkRatingService parkRatingService;
	
	@PostMapping("parks/{pid}/ratings")
	public ParkRating addRating(HttpServletRequest req, HttpServletResponse res, @PathVariable int pid, @RequestBody ParkRating rating, Principal principal) {
		if (rating.getRating() < 1) {
			rating = null;
			res.setStatus(400);
		}
		try {
			rating = parkRatingService.addParkRating(principal.getName(), pid, rating);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(rating.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			rating = null;
		}
		return rating;
	}

}
