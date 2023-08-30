package com.skilldistillery.nationalparks.services;

import java.util.List;

import com.skilldistillery.nationalparks.entities.Attraction;
import com.skilldistillery.nationalparks.entities.AttractionComment;

public interface AttractionService {

	AttractionComment addCommentToAttraction(String username, int attrId, AttractionComment attrComment);

	Attraction show(int id);

	AttractionComment addReplyAttractionComment(String username, int attrId, int attrCommentId,
			AttractionComment attrComReply);

	boolean deleteComment(int attrCommentId);
	
	List<Attraction> showByPark(int parkId);
	
}
