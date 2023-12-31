package com.skilldistillery.nationalparks.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.nationalparks.entities.Park;
import com.skilldistillery.nationalparks.entities.User;
import com.skilldistillery.nationalparks.repositories.ParkRepository;
import com.skilldistillery.nationalparks.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;
	@Autowired
	private ParkRepository parkRepo;

	@Override
	public List<User> index(String username) {
		List<User> allUsers = null;
		User loggedInUser = userRepo.findByUsername(username);
		if (loggedInUser != null) {
			allUsers = userRepo.findAll();
		}
		return allUsers;
	}

	@Override
	public User show(String username, int id) {
		User otherUser = null;
		User loggedInUser = userRepo.findByUsername(username);
		if (loggedInUser != null) {
			otherUser = userRepo.findById(id);
		}
		return otherUser;
	}

	@Override // TODO MAY NOT NEED
	public User update(String username, int id, User user) {
		User loggedInUser = userRepo.findByUsername(username);
		if (loggedInUser != null) {
			User existingUser = userRepo.findById(id);
			if (existingUser != null) {
				if (user.getPassword() != null) {
					existingUser.setPassword(user.getPassword());
				}
				if (user.getFirstName() != null) {
					existingUser.setFirstName(user.getFirstName());
				}
				if (user.getLastName() != null) {
					existingUser.setLastName(user.getLastName());
				}
				if (user.getDescription() != null) {
					existingUser.setDescription(user.getDescription());
				}
				if (user.getImage() != null) {
					existingUser.setImage(user.getImage());
				}
				if (user.isEnabled() != existingUser.isEnabled()) {
					existingUser.setEnabled(user.isEnabled());
				}
				return userRepo.saveAndFlush(existingUser);
			}
			return null;
		}
		return null;
	}

	@Override
	public boolean disableUser(int id) {
		User userForDisable = userRepo.findById(id);
		boolean initialEnabled = userForDisable.isEnabled();
		userForDisable.setEnabled(!userForDisable.isEnabled());
		if (userForDisable.isEnabled() != initialEnabled) {
			userRepo.saveAndFlush(userForDisable);
			return true;
		}
		return false;
	}

	@Override
	public User addParkToUserFavorites(String username, int pid) {
		User loggedInUser = userRepo.findByUsername(username);
		Park existingPark = parkRepo.findById(pid);
		if (existingPark != null) {
			List<Park> favoriteParks = loggedInUser.getFavoriteParks();
			favoriteParks.add(existingPark);
			loggedInUser.setFavoriteParks(favoriteParks);
			parkRepo.saveAndFlush(existingPark);
		}
		return loggedInUser;

	}

	@Override
	public User removeParkFromUserFavorites(String username, int pid) {
		User loggedInUser = userRepo.findByUsername(username);
		Park existingPark = parkRepo.findById(pid);
		if (existingPark != null) {
			loggedInUser.removePark(existingPark);
			parkRepo.saveAndFlush(existingPark);
		}
		return loggedInUser;

	}

	@Override
	public User findByUsername(String username) {
		return userRepo.findByUsername(username);
	}

	// TODO disable/enable if admin

}
