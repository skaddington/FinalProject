package com.skilldistillery.nationalparks.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name="park_rating")
public class ParkRating {

	@Id
	@Embedded
	private ParkRatingId id;
	
	private int rating;
	@Column(name="rating_comment")
	private String ratingComment;
	@Column(name="rating_date")
	@CreationTimestamp
	private LocalDateTime ratingDate;
	
	@ManyToOne
	@JoinColumn(name = "user_id") // DB column name
	@MapsId(value = "userId") 
	private User user;
	@ManyToOne
	@JoinColumn(name = "park_id") // DB column
	@MapsId(value = "parkId")
	private Park park;
	
	public ParkRating() {
	}

	public ParkRatingId getId() {
		return id;
	}

	public void setId(ParkRatingId id) {
		this.id = id;
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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Park getPark() {
		return park;
	}

	public void setPark(Park park) {
		this.park = park;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ParkRating [rating=");
		builder.append(rating);
		builder.append(", ratingComment=");
		builder.append(ratingComment);
		builder.append(", ratingDate=");
		builder.append(ratingDate);
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
		ParkRating other = (ParkRating) obj;
		return Objects.equals(id, other.id);
	}
	
}
