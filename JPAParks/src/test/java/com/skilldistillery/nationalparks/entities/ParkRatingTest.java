package com.skilldistillery.nationalparks.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ParkRatingTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private ParkRating rating;

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
		rating = em.find(ParkRating.class, new ParkRatingId(1,1));
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		rating = null;
	}

	@Test
	void test_ParkRating_basic_mapping() {
		assertNotNull(rating);
		assertEquals("messin with the wildlife,,,,, that's a paddlin", rating.getRatingComment());
	}
	
	@Test
	void test_ParkRating_User_ManyToOne_mapping() {
		assertNotNull(rating);
		assertEquals(1,rating.getUser().getId());
	}
	
	@Test
	void test_ParkRating_Park_ManyToOne_mapping() {
		assertNotNull(rating);
		assertEquals(1,rating.getPark().getId());
	}
	
	

}
