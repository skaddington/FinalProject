package com.skilldistillery.nationalparks.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class ParkRatingId implements Serializable{

	private static final long serialVersionUID = 1L;
	@Column(name="user_id")
	private int userId;
	@Column(name="park_id")
	private int parkId;
	
	public ParkRatingId() {
	}

	public ParkRatingId(int userId, int parkId) {
		this.userId = userId;
		this.parkId = parkId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getParkId() {
		return parkId;
	}

	public void setParkId(int parkId) {
		this.parkId = parkId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ParkRatingId [userId=");
		builder.append(userId);
		builder.append(", parkId=");
		builder.append(parkId);
		builder.append("]");
		return builder.toString();
	}

	@Override
	public int hashCode() {
		return Objects.hash(parkId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ParkRatingId other = (ParkRatingId) obj;
		return parkId == other.parkId && userId == other.userId;
	}
	
}
