package com.skilldistillery.nationalparks.services;

import com.skilldistillery.nationalparks.entities.ParkComment;

public interface ParkCommentService {

	boolean deleteComment(String username, int parkId, int parkCommentId);

	ParkComment addCommentToPark(String username, int parkId, ParkComment parkComment);

	ParkComment show(int id);

	ParkComment addReplyParkComment(String username, int parkId, int parkCommentId,
			ParkComment parkComReply);
	
	
}
