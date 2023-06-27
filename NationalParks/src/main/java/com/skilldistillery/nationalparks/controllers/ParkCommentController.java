package com.skilldistillery.nationalparks.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.nationalparks.entities.Park;
import com.skilldistillery.nationalparks.entities.ParkComment;
import com.skilldistillery.nationalparks.services.ParkCommentService;
import com.skilldistillery.nationalparks.services.ParkService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost/" })
public class ParkCommentController {

	@Autowired
	private ParkService parkService;
	@Autowired
	private ParkCommentService parkCommentService;
	
	
	@GetMapping("parks/{parkId}/comments")
	List<ParkComment> getParkComments(@PathVariable Integer parkId, HttpServletResponse res) {
		Park park = parkService.show(parkId);
		List<ParkComment> comments = park.getParkComments();
		return comments;
	}

	@PostMapping("parks/{parkId}/comments")
	public ParkComment addParkComment(HttpServletRequest req, HttpServletResponse res,
			@PathVariable Integer parkId, @RequestBody ParkComment parkComment, Principal principal) {
		if (parkComment.getContent().isEmpty()) {
			parkComment = null;
			res.setStatus(400);
		}
		try {
			parkComment = parkCommentService.addCommentToPark(principal.getName(), parkId, parkComment);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(parkComment.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			parkComment = null;
		}
		return parkComment;
	}

	@DeleteMapping("parks/{parkId}/comments/{commentId}")
	public void deleteComment(Principal principal, HttpServletResponse res, @PathVariable Integer parkId,
			@PathVariable Integer commentId) {
		System.out.println(principal.getName() + " " + parkId + " " + commentId);
		if (parkCommentService.deleteComment(principal.getName(), parkId, commentId)) {
			res.setStatus(204);
		} else {
			res.setStatus(404);
		}
	}

	@PostMapping("parks/{parkId}/comments/{commentId}")
	public ParkComment addReplyComment(HttpServletRequest req, HttpServletResponse res,
			@PathVariable Integer parkId, @PathVariable Integer commentId,
			@RequestBody ParkComment parkComment, Principal principal) {
		
		if (parkComment.getContent().isEmpty()) {
			parkComment = null;
			res.setStatus(404);
		}
		try {
			parkComment = parkCommentService.addReplyParkComment(principal.getName(), parkId, commentId,
					parkComment);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(parkComment.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			parkComment = null;
		}
		return parkComment;

	}
	
}
