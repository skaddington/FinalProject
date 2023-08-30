package com.skilldistillery.nationalparks.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.nationalparks.entities.Attraction;
import com.skilldistillery.nationalparks.entities.AttractionComment;
import com.skilldistillery.nationalparks.entities.User;
import com.skilldistillery.nationalparks.repositories.AttractionCommentRepository;
import com.skilldistillery.nationalparks.repositories.AttractionRepository;
import com.skilldistillery.nationalparks.repositories.UserRepository;

@Service
public class AttractionServiceImpl implements AttractionService {
	
	@Autowired
	private AttractionRepository attractionRepo;
	@Autowired
	private AttractionCommentRepository attractionCommentRepo;
	@Autowired
	private UserRepository userRepo;
	
	@Override
	public Attraction show(int id) {
		Attraction managedAttraction = attractionRepo.findById(id);
		return managedAttraction;
	}
	
	@Override
	public AttractionComment addCommentToAttraction(String username, int attrId, AttractionComment attrComment) {
		User managedUser = userRepo.findByUsername(username);
		Attraction managedAttraction = attractionRepo.findById(attrId);
		attrComment.setAttraction(managedAttraction);
		attrComment.setUser(managedUser);
		AttractionComment newAttractionComment = attractionCommentRepo.saveAndFlush(attrComment);
		managedAttraction.addAttractionComment(newAttractionComment);
		managedUser.addAttractionComment(newAttractionComment);
		return newAttractionComment;
	}
	
	@Override
	public AttractionComment addReplyAttractionComment(String username, int attrId, int attrCommentId, AttractionComment attrComReply) {
		User managedUser = userRepo.findByUsername(username);
		Attraction managedAttraction = attractionRepo.findById(attrId);
		AttractionComment managedComment = attractionCommentRepo.findById(attrCommentId);
		attrComReply.setAttraction(managedAttraction);
		attrComReply.setUser(managedUser);
		attrComReply.setComment(managedComment);
		AttractionComment managedReply = attractionCommentRepo.saveAndFlush(attrComReply);
		managedAttraction.addAttractionComment(managedReply);
		managedUser.addAttractionComment(managedReply);
		managedComment.addAttractionCommentReply(managedReply);
		return managedReply;
		
	}
	
	@Override
	public boolean deleteComment(int attrCommentId) {
		AttractionComment managedComment = attractionCommentRepo.findById(attrCommentId);
		boolean currentEnabled = managedComment.getEnabled();
		managedComment.setEnabled(!managedComment.getEnabled());
		attractionCommentRepo.saveAndFlush(managedComment);
		if (managedComment.getEnabled() != currentEnabled) {
			return true;
		}
		return false;
	}
	
	@Override
	public List<Attraction> showByPark(int parkId) {
		List<Attraction> managedAttractions = attractionRepo.findByPark_Id(parkId);
		return managedAttractions;
	}

}
