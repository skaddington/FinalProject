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
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "park_comment")
public class ParkComment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String content;
	@Column(name = "created_at")
	@CreationTimestamp
	private LocalDateTime createdAt;
	private Boolean enabled;
	
	@JsonIgnoreProperties({"parkComments", "favoriteParks", "attractions", "attractionComments"})
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;
	
	@JsonIgnoreProperties({"parkComments", "favoriteParks", "attractions", "attractionComments"})
	@ManyToOne
	@JoinColumn(name = "park_id")
	private Park park;
	@JsonIgnoreProperties({"replies"})
	@ManyToOne
	@JoinColumn(name = "reply_to_id")
	private ParkComment comment;

	@OneToMany(mappedBy = "comment")
	private List<ParkComment> replies;

	public ParkComment() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
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

	public ParkComment getComment() {
		return comment;
	}

	public void setComment(ParkComment comment) {
		this.comment = comment;
	}

	public List<ParkComment> getReplies() {
		return replies;
	}

	public void setReplies(List<ParkComment> replies) {
		this.replies = replies;
	}

	public void addParkComment(ParkComment comment) {
		if (replies == null) {
			replies = new ArrayList<>();
		}
		if (!replies.contains(comment)) {
			replies.add(comment);
			if (comment.getComment() != null) {
				comment.getComment().removeParkComment(comment);

			} else {
				comment.setComment(this);
			}
		}
	}

	public void removeParkComment(ParkComment comment) {
		if (replies != null && replies.contains(comment)) {
			replies.remove(comment);
			comment.setComment(null);
		}
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ParkComment [id=");
		builder.append(id);
		builder.append(", content=");
		builder.append(content);
		builder.append(", createdAt=");
		builder.append(createdAt);
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
		ParkComment other = (ParkComment) obj;
		return id == other.id;
	}

}
