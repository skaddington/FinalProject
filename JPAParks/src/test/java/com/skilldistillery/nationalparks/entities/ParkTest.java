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

class ParkTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Park park;

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
		park = em.find(Park.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		park = null;
	}

	@Test
	void test_Park_basic_mapping() {
		assertNotNull(park);
		assertEquals("Acadia National Park", park.getName());
	}
	
	@Test
	void test_Park_Activity_ManyToMany_mapping() {
		assertNotNull(park);
		assertTrue(park.getActivities().size()>0);
	}
	
	@Test
	void test_Park_Attraction_OneToMany_mapping() {
		assertNotNull(park);
		assertTrue(park.getAttractions().size()>0);
	}
	
	@Test
	void test_Park_State_ManyToMany_mapping() {
		assertNotNull(park);
		assertTrue(park.getStates().size()>0);
	}
	
	@Test
	void test_Park_ParkPhoto_OneToMany_mapping() {
		assertNotNull(park);
		assertTrue(park.getParkPhotos().size()>0);
	}
	
	@Test
	void test_Park_UserFavorites_ManyToMany_mapping() {
		assertNotNull(park);
		assertTrue(park.getUsers().size()>0);
	}
	
	@Test
	void test_Park_ParkComment_OneToMany_mapping() {
		assertNotNull(park);
		assertTrue(park.getParkComments().size()>0);
	}
	
	@Test
	void test_Park_ParkRating_OneToMany_mapping() {
		assertNotNull(park);
		assertTrue(park.getParkRatings().size()>0);
	}

}
