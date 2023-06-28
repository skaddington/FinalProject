package com.skilldistillery.nationalparks.entities;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Park {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;
	@Column(name = "date_established")
	private LocalDate dateEstablished;
	private String description;
	@Column(name = "image_url")
	private String image;
	@Column(name = "website_url")
	private String website;
	private String street;
	private String city;
	private String state;
	private String zip;

	@JsonIgnoreProperties({"parks"})
	@ManyToMany(mappedBy = "parks")
	private List<Activity> activities;
	
	@JsonIgnoreProperties({"user", "park"})
	@OneToMany(mappedBy = "park")
	private List<Attraction> attractions;
	
	//@JsonIgnore
	@JsonIgnoreProperties({"parks"})
	@ManyToMany(mappedBy = "parks")
	private List<State> states;
	@JsonIgnore
	@ManyToMany(mappedBy = "favoriteParks")
	private List<User> users;
	
	@OneToMany(mappedBy = "park")
	private List<ParkPhoto> parkPhotos;
	@JsonIgnoreProperties({"park"})
	@OneToMany(mappedBy = "park")
	private List<ParkComment> parkComments;
	@JsonIgnoreProperties({"park", "user"})
	@OneToMany(mappedBy = "park")
	private List<ParkRating> parkRatings;

	public Park() {
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

	public LocalDate getDateEstablished() {
		return dateEstablished;
	}

	public void setDateEstablished(LocalDate dateEstablished) {
		this.dateEstablished = dateEstablished;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	public List<Activity> getActivities() {
		return activities;
	}

	public void setActivities(List<Activity> activities) {
		this.activities = activities;
	}

	public List<Attraction> getAttractions() {
		return attractions;
	}

	public void setAttractions(List<Attraction> attractions) {
		this.attractions = attractions;
	}

	public List<State> getStates() {
		return states;
	}

	public void setStates(List<State> states) {
		this.states = states;
	}

	public List<ParkPhoto> getParkPhotos() {
		return parkPhotos;
	}

	public void setParkPhotos(List<ParkPhoto> parkPhotos) {
		this.parkPhotos = parkPhotos;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
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

	public void addParkRating(ParkRating parkRating) {
		if (parkRatings == null) {
			parkRatings = new ArrayList<>();
		}
		if (!parkRatings.contains(parkRating)) {
			parkRatings.add(parkRating);
			if (parkRating.getPark() != null) {
				parkRating.getPark().removeParkRating(parkRating);

			} else {
				parkRating.setPark(this);
			}
		}
	}

	public void removeParkRating(ParkRating parkRating) {
		if (parkRatings != null && parkRatings.contains(parkRating)) {
			parkRatings.remove(parkRating);
			parkRating.setPark(null);
		}
	}

	public void addParkComment(ParkComment parkComment) {
		if (parkComments == null) {
			parkComments = new ArrayList<>();
		}
		if (!parkComments.contains(parkComment)) {
			parkComments.add(parkComment);
			if (parkComment.getPark() != null) {
				parkComment.getPark().removeParkComment(parkComment);

			} else {
				parkComment.setPark(this);
			}
		}
	}

	public void removeParkComment(ParkComment parkComment) {
		if (parkComments != null && parkComments.contains(parkComment)) {
			parkComments.remove(parkComment);
			parkComment.setPark(null);
		}
	}

	public void addParkPhoto(ParkPhoto parkPhoto) {
		if (parkPhotos == null) {
			parkPhotos = new ArrayList<>();
		}
		if (!parkPhotos.contains(parkPhoto)) {
			parkPhotos.add(parkPhoto);
			if (parkPhoto.getPark() != null) {
				parkPhoto.getPark().removeParkPhoto(parkPhoto);

			} else {
				parkPhoto.setPark(this);
			}
		}
	}

	public void removeParkPhoto(ParkPhoto parkPhoto) {
		if (parkPhotos != null && parkPhotos.contains(parkPhoto)) {
			parkPhotos.remove(parkPhoto);
			parkPhoto.setPark(null);
		}
	}

	public void addAttraction(Attraction attraction) {
		if (attractions == null) {
			attractions = new ArrayList<>();
		}
		if (!attractions.contains(attraction)) {
			attractions.add(attraction);
			if (attraction.getPark() != null) {
				attraction.getPark().removeAttraction(attraction);

			} else {
				attraction.setPark(this);
			}
		}
	}

	public void removeAttraction(Attraction attraction) {
		if (attractions != null && attractions.contains(attraction)) {
			attractions.remove(attraction);
			attraction.setPark(null);
		}
	}

	public void addActivity(Activity activity) {
		if (activities == null) {
			activities = new ArrayList<>();
		}
		if (!activities.contains(activity)) {
			activities.add(activity);
			activity.addPark(this);
		}
	}

	public void removeActivity(Activity activity) {
		if (activities != null && activities.contains(activity)) {
			activities.remove(activity);
			activity.removePark(this);
		}
	}

	public void addState(State state) {
		if (states == null) {
			states = new ArrayList<>();
		}
		if (!states.contains(state)) {
			states.add(state);
			state.addPark(this);
		}
	}

	public void removeState(State state) {
		if (states != null && states.contains(state)) {
			states.remove(state);
			state.removePark(this);
		}
	}

	public void addUser(User user) {
		if (users == null) {
			users = new ArrayList<>();
		}
		if (!users.contains(user)) {
			users.add(user);
			user.addPark(this);
		}
	}

	public void removeUser(User user) {
		if (users != null && users.contains(user)) {
			users.remove(user);
			user.removePark(this);
		}
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Park [id=");
		builder.append(id);
		builder.append(", name=");
		builder.append(name);
		builder.append(", dateEstablished=");
		builder.append(dateEstablished);
		builder.append(", description=");
		builder.append(description);
		builder.append(", image=");
		builder.append(image);
		builder.append(", website=");
		builder.append(website);
		builder.append(", street=");
		builder.append(street);
		builder.append(", city=");
		builder.append(city);
		builder.append(", state=");
		builder.append(state);
		builder.append(", zip=");
		builder.append(zip);
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
		Park other = (Park) obj;
		return id == other.id;
	}

}
