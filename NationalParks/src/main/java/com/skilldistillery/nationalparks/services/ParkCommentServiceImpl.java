package com.skilldistillery.nationalparks.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.nationalparks.entities.Attraction;
import com.skilldistillery.nationalparks.entities.AttractionComment;
import com.skilldistillery.nationalparks.entities.Park;
import com.skilldistillery.nationalparks.entities.ParkComment;
import com.skilldistillery.nationalparks.entities.User;
import com.skilldistillery.nationalparks.repositories.ParkCommentRepository;
import com.skilldistillery.nationalparks.repositories.ParkRepository;
import com.skilldistillery.nationalparks.repositories.UserRepository;

@Service
public class ParkCommentServiceImpl implements ParkCommentService {

	@Autowired
	private UserRepository userRepo;
	@Autowired
	private ParkRepository parkRepo;
	@Autowired
	private ParkCommentRepository parkCommentRepo;

	@Override
	public ParkComment show(int id) {
		ParkComment managedComment = parkCommentRepo.findById(id);
		return managedComment;
	}

	@Override
	public boolean deleteComment(String username, int parkId, int parkCommentId) {
		User managedUser = userRepo.findByUsername(username);
		Park managedPark = parkRepo.findById(parkId);
		ParkComment managedComment = parkCommentRepo.findById(parkCommentId);
		if (managedComment != null) {
			managedUser.removeParkComment(managedComment);
			managedPark.removeParkComment(managedComment);
			if (managedComment.getComment() != null) {
				managedComment.getComment().removeParkComment(managedComment);
			}
			parkCommentRepo.delete(managedComment);
			return true;
		}
		return false;
	}

	@Override
	public ParkComment addCommentToPark(String username, int parkId, ParkComment parkComment) {
		User managedUser = userRepo.findByUsername(username);
		Park managedPark = parkRepo.findById(parkId);
		parkComment.setPark(managedPark);
		parkComment.setUser(managedUser);
		ParkComment newParkComment = parkCommentRepo.saveAndFlush(parkComment);
		managedPark.addParkComment(newParkComment);
		managedUser.addParkComment(newParkComment);
		return newParkComment;
	}

	@Override
	public ParkComment addReplyParkComment(String username, int parkId, int parkCommentId, ParkComment parkComReply) {
		User managedUser = userRepo.findByUsername(username);
		Park managedPark = parkRepo.findById(parkId);
		ParkComment managedComment = parkCommentRepo.findById(parkCommentId);
		parkComReply.setPark(managedPark);
		parkComReply.setUser(managedUser);
		parkComReply.setComment(managedComment);
		ParkComment managedReply = parkCommentRepo.saveAndFlush(parkComReply);
		managedPark.addParkComment(managedReply);
		managedComment.addParkComment(managedReply);
		managedUser.addParkComment(managedReply);
		return managedReply;
	}

}
