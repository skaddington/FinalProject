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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "attraction_comment")
public class AttractionComment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String content;
	@Column(name = "created_at")
	@CreationTimestamp
	private LocalDateTime createdAt;
	private Boolean enabled;
	
	@JsonIgnoreProperties({"attractionComments", "attractions", "favoriteParks", "parkComments", "parkRatings", "parkPhotos"})
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@JsonIgnoreProperties({"replies"})
	@ManyToOne
	@JoinColumn(name = "reply_to_id")
	private AttractionComment comment;
	
	@OneToMany(mappedBy = "comment")
	private List<AttractionComment> replies;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "attraction_id")
	private Attraction attraction;

	public AttractionComment() {
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


	public Attraction getAttraction() {
		return attraction;
	}

	public AttractionComment getComment() {
		return comment;
	}

	public void setComment(AttractionComment comment) {
		this.comment = comment;
	}

	public List<AttractionComment> getReplies() {
		return replies;
	}

	public void setReplies(List<AttractionComment> replies) {
		this.replies = replies;
	}

	public void setAttraction(Attraction attraction) {
		this.attraction = attraction;
	}

	public void addAttractionCommentReply(AttractionComment attractionCommentReply) {
		if (replies == null) {
			replies = new ArrayList<>();
		}
		if (!replies.contains(attractionCommentReply)) {
			replies.add(attractionCommentReply);
			if (attractionCommentReply.getComment() != null) {
				attractionCommentReply.getComment().removeAttractionCommentReply(attractionCommentReply);

			} else {
				attractionCommentReply.setComment(this);
			}
		}
	}

	public void removeAttractionCommentReply(AttractionComment attractionCommentReply) {
		if (replies != null && replies.contains(attractionCommentReply)) {
			replies.remove(attractionCommentReply);
			attractionCommentReply.setComment(null);
		}
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("AttractionComment [id=");
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
		AttractionComment other = (AttractionComment) obj;
		return id == other.id;
	}

}
