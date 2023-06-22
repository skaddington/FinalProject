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

class AttractionRatingTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private AttractionRating attrRate;

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
		attrRate = em.find(AttractionRating.class, new AttractionRatingId(1,1));
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		attrRate = null;
	}

	@Test
	void test_AttractionRating_basic_mapping() {
		assertNotNull(attrRate);
		assertEquals("testdata", attrRate.getRatingComment());
	}
	
	@Test
	void test_AttractionRating_Attraction_ManyToOne_mapping() {
		assertNotNull(attrRate);
		assertEquals(1, attrRate.getAttraction().getId());
	}
	
	@Test
	void test_AttractionRating_User_ManyToOne_mapping() {
		assertNotNull(attrRate);
		assertEquals(1, attrRate.getUser().getId());
	}

}
