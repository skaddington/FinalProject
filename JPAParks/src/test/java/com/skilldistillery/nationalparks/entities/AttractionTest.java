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

class AttractionTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Attraction attr;

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
		attr = em.find(Attraction.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		attr = null;
	}

	@Test
	void test_Attraction_basic_mapping() {
		assertNotNull(attr);
		assertEquals("burgerplace", attr.getName());
	}
	
	@Test
	void test_Attraction_Park_ManyToOne_mapping() {
		assertNotNull(attr);
		assertEquals(1,attr.getPark().getId());
	}
	
	@Test
	void test_Attraction_User_ManyToOne_mapping() {
		assertNotNull(attr);
		assertEquals(1,attr.getUser().getId());
	}
	
	@Test
	void test_Attraction_AttractionComment_OneToMany_mapping() {
		assertNotNull(attr);
		assertTrue(attr.getAttractionComments().size()>0);
	}
	
	@Test
	void test_Attraction_AttractionRating_OneToMany_mapping() {
		assertNotNull(attr);
		assertTrue(attr.getRatings().size()>0);
	}

}
