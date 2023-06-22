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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String username;
	private String password;
	private boolean enabled;
	private String role;
	@Column(name = "first_name")
	private String firstName;
	@Column(name = "last_name")
	private String lastName;
	@Column(name = "image_url")
	private String image;
	private String description;
	@Column(name = "created_at")
	@CreationTimestamp
	private LocalDateTime createdAt;
	@Column(name = "updated_at")
	@UpdateTimestamp
	private LocalDateTime updatedAt;

	@OneToMany(mappedBy = "user")
	private List<Attraction> attractions;
	@ManyToMany
	@JoinTable(name = "user_favorites", 
	joinColumns = @JoinColumn(name = "park_id"), 
	inverseJoinColumns = @JoinColumn(name = "user_id"))
	private List<Park> favoriteParks;
	@OneToMany(mappedBy = "park")
	private List<ParkComment> parkComments;
	@OneToMany(mappedBy = "user")
	private List<ParkRating> parkRatings;
	@OneToMany(mappedBy = "user")
	private List<ParkPhoto> parkPhotos;

	public User() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
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

	public List<Attraction> getAttractions() {
		return attractions;
	}

	public void setAttractions(List<Attraction> attractions) {
		this.attractions = attractions;
	}

	public List<Park> getFavoriteParks() {
		return favoriteParks;
	}

	public void setFavoriteParks(List<Park> favoriteParks) {
		this.favoriteParks = favoriteParks;
	}

	public List<ParkComment> getParkComments() {
		return parkComments;
	}

	public void setParkComments(List<ParkComment> parkComments) {
		this.parkComments = parkComments;
	}

	public List<ParkRating> getParkRatings() {
		return parkRatings;
	}

	public void setParkRatings(List<ParkRating> parkRatings) {
		this.parkRatings = parkRatings;
	}

	public List<ParkPhoto> getParkPhotos() {
		return parkPhotos;
	}

	public void setParkPhotos(List<ParkPhoto> parkPhotos) {
		this.parkPhotos = parkPhotos;
	}

	public void addParkPhoto(ParkPhoto parkPhoto) {
		if (parkPhotos == null) {
			parkPhotos = new ArrayList<>();
		}
		if (!parkPhotos.contains(parkPhoto)) {
			parkPhotos.add(parkPhoto);
			if (parkPhoto.getUser() != null) {
				parkPhoto.getUser().removeParkPhoto(parkPhoto);

			} else {
				parkPhoto.setUser(this);
			}
		}
	}

	public void removeParkPhoto(ParkPhoto parkPhoto) {
		if (parkPhotos != null && parkPhotos.contains(parkPhoto)) {
			parkPhotos.remove(parkPhoto);
			parkPhoto.setUser(null);
		}
	}

	public void addParkRating(ParkRating parkRating) {
		if (parkRatings == null) {
			parkRatings = new ArrayList<>();
		}
		if (!parkRatings.contains(parkRating)) {
			parkRatings.add(parkRating);
			if (parkRating.getUser() != null) {
				parkRating.getUser().removeParkRating(parkRating);

			} else {
				parkRating.setUser(this);
			}
		}
	}

	public void removeParkRating(ParkRating parkRating) {
		if (parkRatings != null && parkRatings.contains(parkRating)) {
			parkRatings.remove(parkRating);
			parkRating.setUser(null);
		}
	}

	public void addParkComment(ParkComment parkComment) {
		if (parkComments == null) {
			parkComments = new ArrayList<>();
		}
		if (!parkComments.contains(parkComment)) {
			parkComments.add(parkComment);
			if (parkComment.getUser() != null) {
				parkComment.getUser().removeParkComment(parkComment);

			} else {
				parkComment.setUser(this);
			}
		}
	}

	public void removeParkComment(ParkComment parkComment) {
		if (parkComments != null && parkComments.contains(parkComment)) {
			parkComments.remove(parkComment);
			parkComment.setUser(null);
		}
	}

	public void addPark(Park favoritePark) {
		if (favoriteParks == null) {
			favoriteParks = new ArrayList<>();
		}
		if (!favoriteParks.contains(favoritePark)) {
			favoriteParks.add(favoritePark);
			favoritePark.addUser(this);
		}
	}

	public void removePark(Park favoritePark) {
		if (favoriteParks != null && favoriteParks.contains(favoritePark)) {
			favoriteParks.remove(favoritePark);
			favoritePark.removeUser(this);
		}
	}

	public void addAttraction(Attraction attraction) {
		if (attractions == null) {
			attractions = new ArrayList<>();
		}
		if (!attractions.contains(attraction)) {
			attractions.add(attraction);
			if (attraction.getUser() != null) {
				attraction.getUser().removeAttraction(attraction);

			} else {
				attraction.setUser(this);
			}
		}
	}

	public void removeAttraction(Attraction attraction) {
		if (attractions != null && attractions.contains(attraction)) {
			attractions.remove(attraction);
			attraction.setUser(null);
		}
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("User [id=");
		builder.append(id);
		builder.append(", username=");
		builder.append(username);
		builder.append(", password=");
		builder.append(password);
		builder.append(", enabled=");
		builder.append(enabled);
		builder.append(", role=");
		builder.append(role);
		builder.append(", firstName=");
		builder.append(firstName);
		builder.append(", lastName=");
		builder.append(lastName);
		builder.append(", image=");
		builder.append(image);
		builder.append(", description=");
		builder.append(description);
		builder.append(", createdAt=");
		builder.append(createdAt);
		builder.append(", updatedAt=");
		builder.append(updatedAt);
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
		User other = (User) obj;
		return id == other.id;
	}

}
