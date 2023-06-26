package com.skilldistillery.nationalparks.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.nationalparks.entities.AttractionComment;

public interface AttractionCommentRepository extends JpaRepository<AttractionComment, Integer> {

	AttractionComment findById(int id);
	List<AttractionComment> findByAttraction_id(int attrId);
	List<AttractionComment> findByAttraction_name(String name);
}
