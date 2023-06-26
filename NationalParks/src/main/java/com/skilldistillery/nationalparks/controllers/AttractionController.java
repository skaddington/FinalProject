package com.skilldistillery.nationalparks.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.nationalparks.entities.Attraction;
import com.skilldistillery.nationalparks.entities.AttractionComment;
import com.skilldistillery.nationalparks.services.AttractionService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost/"})
public class AttractionController {

	@Autowired
	private AttractionService attrService;
	
	@GetMapping("attractions/{attrId}/comments")
	List<AttractionComment> getAttrComments(@PathVariable Integer attrId, HttpServletResponse res) {
		Attraction attraction = attrService.show(attrId);
		List<AttractionComment> comments = attraction.getAttractionComments();
		return comments;
	}
	
	
	@PostMapping("attractions/{attrId}/comments")
	public AttractionComment addAttractionComment(HttpServletRequest req, 
			HttpServletResponse res, @PathVariable Integer attrId, @RequestBody
			AttractionComment attractionComment, Principal principal) {
		if(attractionComment.getContent().isEmpty()) {
			attractionComment = null;
			res.setStatus(400);
		} try {
			attractionComment = attrService.addCommentToAttraction(principal.getName(), attrId, attractionComment);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(attractionComment.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			attractionComment = null;
		}
		return attractionComment;
	}
	
	
	
}
