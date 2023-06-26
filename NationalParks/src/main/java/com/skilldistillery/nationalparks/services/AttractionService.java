package com.skilldistillery.nationalparks.services;

import com.skilldistillery.nationalparks.entities.Attraction;
import com.skilldistillery.nationalparks.entities.AttractionComment;

public interface AttractionService {

	AttractionComment addCommentToAttraction(String username, int attrId, AttractionComment attrComment);

	boolean deleteComment(String username, int attrId, int attrCommentId);

	Attraction show(int id);
	
	
	
	
	
}
