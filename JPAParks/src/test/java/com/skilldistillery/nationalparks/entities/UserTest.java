package com.skilldistillery.nationalparks.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class UserTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAParks");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
	emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
	}

	@Test
	void test_User_Entity_mapping() {
		assertNotNull(user);
		assertEquals("admin", user.getUsername());
	}
	
	@Test
	void test_User_Attraction_OneToMany_mapping() {
		assertNotNull(user);
		assertTrue(user.getAttractions().size()>0);
	}
	
	@Test
	void test_User_ParkRating_OneToMany_mapping() {
		assertNotNull(user);
		assertTrue(user.getParkRatings().size()>0);
	}
	
	@Test
	void test_User_Park_ManyToMany_mapping() {
		assertNotNull(user);
		assertTrue(user.getFavoriteParks().size()>0);
	}
	
	@Test
	void test_User_ParkComment_OneToMany_mapping() {
		assertNotNull(user);
		assertTrue(user.getParkComments().size()>0);
	}
	
	@Test
	void test_User_ParkPhoto_OneToMany_mapping() {
		assertNotNull(user);
		assertTrue(user.getParkPhotos().size()>0);
	}
	
	
	

}
