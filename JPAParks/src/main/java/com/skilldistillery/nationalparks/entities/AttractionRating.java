package com.skilldistillery.nationalparks.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name="attraction_rating")
public class AttractionRating {

	@EmbeddedId
	private AttractionRatingId id;
	
	private int rating;
	@Column(name="rating_comment")
	private String ratingComment;
	@Column(name="rating_date")
	@CreationTimestamp
	private LocalDateTime ratingDate;
	
	@ManyToOne
	@JoinColumn(name = "user_id") // DB column name
	@MapsId(value = "userId")     // Field in ID class
	private User user;
	@ManyToOne
	@JoinColumn(name = "attraction_id") // DB column
	@MapsId(value = "attractionId")
	private Attraction attraction;
	
	public AttractionRating() {
	}

	public AttractionRatingId getId() {
		return id;
	}

	public void setId(AttractionRatingId id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getRatingComment() {
		return ratingComment;
	}

	public void setRatingComment(String ratingComment) {
		this.ratingComment = ratingComment;
	}

	public LocalDateTime getRatingDate() {
		return ratingDate;
	}

	public void setRatingDate(LocalDateTime ratingDate) {
		this.ratingDate = ratingDate;
	}

	public Attraction getAttraction() {
		return attraction;
	}

	public void setAttraction(Attraction attraction) {
		this.attraction = attraction;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("AttractionRating [id=");
		builder.append(id);
		builder.append(", user=");
		builder.append(user);
		builder.append(", rating=");
		builder.append(rating);
		builder.append(", ratingComment=");
		builder.append(ratingComment);
		builder.append(", ratingDate=");
		builder.append(ratingDate);
		builder.append(", attraction=");
		builder.append(attraction);
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
		AttractionRating other = (AttractionRating) obj;
		return Objects.equals(id, other.id);
	}
	
}
