package com.skilldistillery.nationalparks.services;

import com.skilldistillery.nationalparks.entities.Attraction;
import com.skilldistillery.nationalparks.entities.AttractionComment;

public interface AttractionService {

	boolean deleteComment(String username, int attrId, int attrCommentId);

	AttractionComment addCommentToAttraction(String username, int attrId, AttractionComment attrComment);

	Attraction show(int id);

	AttractionComment addReplyAttractionComment(String username, int attrId, int attrCommentId,
			AttractionComment attrComReply);
	
	
	
	
	
}
