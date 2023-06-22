package com.skilldistillery.nationalparks.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

@Entity
public class State {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String abbreviation;
	private String name;

	@ManyToMany
	@JoinTable(name = "park_has_state", joinColumns = @JoinColumn(name = "park_id"), inverseJoinColumns = @JoinColumn(name = "state_id"))
	private List<Park> parks;

	public State() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAbbreviation() {
		return abbreviation;
	}

	public void setAbbreviation(String abbreviation) {
		this.abbreviation = abbreviation;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Park> getParks() {
		return parks;
	}

	public void setParks(List<Park> parks) {
		this.parks = parks;
	}

	public void addPark(Park park) {
		if (parks == null) {
			parks = new ArrayList<>();
		}
		if (!parks.contains(park)) {
			parks.add(park);
			park.addState(this);
		}
	}

	public void removePark(Park park) {
		if (parks != null && parks.contains(park)) {
			parks.remove(park);
			park.removeState(this);
		}
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("State [id=");
		builder.append(id);
		builder.append(", abbreviation=");
		builder.append(abbreviation);
		builder.append(", name=");
		builder.append(name);
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
		State other = (State) obj;
		return id == other.id;
	}

}
