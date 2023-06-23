package com.skilldistillery.nationalparks.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.nationalparks.entities.Park;
import com.skilldistillery.nationalparks.services.ParkService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost/"})
public class ParkController {
	
	@Autowired
	private ParkService parkService;
	
	@GetMapping("parks")
	public List<Park> index(HttpServletRequest req, HttpServletResponse res) {
		return parkService.index();
	}
	
	@GetMapping("parks/{pid}")
	public Park show(HttpServletRequest req, HttpServletResponse res, @PathVariable int pid) {
		Park park = parkService.show(pid);
		if(park == null) {
			res.setStatus(404);
		}
		return park;
	}
	
	@PutMapping("parks/{pid}")
	public Park update(HttpServletRequest req, HttpServletResponse res, @PathVariable int pid, @RequestBody Park park) {
		try {
			park = parkService.updatePark(pid, park);
			if(park == null) {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			park = null;
		}
		return park;
	}
	

}
