package com.skilldistillery.nationalparks.services;

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
	public boolean deleteComment(String username, int attrId, int attrCommentId) {
		User managedUser = userRepo.findByUsername(username);
		Attraction managedAttraction = attractionRepo.findById(attrId);
		AttractionComment managedComment = attractionCommentRepo.findById(attrCommentId);
		if(managedComment!=null) {
			managedUser.removeAttractionComment(managedComment);
			managedAttraction.removeAttractionComment(managedComment);
			attractionCommentRepo.delete(managedComment);
			return true;
		}
		return false;
	}
}
