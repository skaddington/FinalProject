package com.skilldistillery.nationalparks.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Attraction {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	private String description;
	@Column(name = "created_at")
	@CreationTimestamp
	private LocalDateTime createdAt;
	@Column(name = "updated_at")
	@UpdateTimestamp
	private LocalDateTime updatedAt;
	@Column(name = "image_url")
	private String image;
	@Column(name = "website_url")
	private String website;
	private Boolean enabled;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "park_id")
	private Park park;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;
	
	@JsonIgnore
	@OneToMany(mappedBy = "attraction")
	private List<AttractionComment> attractionComments;
	
	@JsonIgnore
	@OneToMany(mappedBy = "attraction")
	private List<AttractionRating> ratings;

	public Attraction() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public Park getPark() {
		return park;
	}

	public void setPark(Park park) {
		this.park = park;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<AttractionComment> getAttractionComments() {
		return attractionComments;
	}

	public void setAttractionComments(List<AttractionComment> attractionComments) {
		this.attractionComments = attractionComments;
	}

	public List<AttractionRating> getRatings() {
		return ratings;
	}

	public void setRatings(List<AttractionRating> ratings) {
		this.ratings = ratings;
	}

	public void addAttractionRating(AttractionRating rating) {
		if (ratings == null) {
			ratings = new ArrayList<>();
		}
		if (!ratings.contains(rating)) {
			ratings.add(rating);
			if (rating.getAttraction() != null) {
				rating.getAttraction().removeAttractionRating(rating);

			} else {
				rating.setAttraction(this);
			}
		}
	}

	public void removeAttractionRating(AttractionRating rating) {
		if (ratings != null && ratings.contains(rating)) {
			ratings.remove(rating);
			rating.setAttraction(null);
		}
	}

	public void addAttractionComment(AttractionComment attractionComment) {
		if (attractionComments == null) {
			attractionComments = new ArrayList<>();
		}
		if (!attractionComments.contains(attractionComment)) {
			attractionComments.add(attractionComment);
			if (attractionComment.getAttraction() != null) {
				attractionComment.getAttraction().removeAttractionComment(attractionComment);

			} else {
				attractionComment.setAttraction(this);
			}
		}
	}

	public void removeAttractionComment(AttractionComment attractionComment) {
		if (attractionComments != null && attractionComments.contains(attractionComment)) {
			attractionComments.remove(attractionComment);
			attractionComment.setAttraction(null);
		}
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Attraction [id=");
		builder.append(id);
		builder.append(", name=");
		builder.append(name);
		builder.append(", description=");
		builder.append(description);
		builder.append(", createdAt=");
		builder.append(createdAt);
		builder.append(", updatedAt=");
		builder.append(updatedAt);
		builder.append(", image=");
		builder.append(image);
		builder.append(", website=");
		builder.append(website);
		builder.append(", enabled=");
		builder.append(enabled);
		builder.append("]");
		return builder.toString();
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Attraction other = (Attraction) obj;
		return id == other.id;
	}

}
