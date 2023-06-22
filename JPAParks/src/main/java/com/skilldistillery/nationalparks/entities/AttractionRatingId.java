package com.skilldistillery.nationalparks.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class AttractionRatingId implements Serializable{

	private static final long serialVersionUID = 1L;
	@Column(name="user_id")
	private int userId;
	@Column(name="attraction_id")
	private int attractionId;
	
	public AttractionRatingId() {
	}

	public AttractionRatingId(int userId, int attractionId) {
		this.userId = userId;
		this.attractionId = attractionId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getAttractionId() {
		return attractionId;
	}

	public void setAttractionId(int attractionId) {
		this.attractionId = attractionId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("AttractionRatingId [userId=");
		builder.append(userId);
		builder.append(", attractionId=");
		builder.append(attractionId);
		builder.append("]");
		return builder.toString();
	}

	@Override
	public int hashCode() {
		return Objects.hash(attractionId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AttractionRatingId other = (AttractionRatingId) obj;
		return attractionId == other.attractionId && userId == other.userId;
	}
	
}
