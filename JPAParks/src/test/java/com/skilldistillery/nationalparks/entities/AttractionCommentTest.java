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


class AttractionCommentTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private AttractionComment attrComm;

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
		attrComm = em.find(AttractionComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		attrComm = null;
	}

	@Test
	void test_AttractionComment_basic_mapping() {
		assertNotNull(attrComm);
		assertEquals("idk what to put here", attrComm.getContent());
	}
	
	@Test
	void test_AttractionComment_Attraction_ManyToOne_mapping() {
		assertNotNull(attrComm);
		assertEquals(1,attrComm.getAttraction().getId());
	}
	
	@Test
	void test_AttractionComment_AttractionCommentReplies_OneToMany_mapping() {
		attrComm = null;
		attrComm = em.find(AttractionComment.class, 2);
		assertNotNull(attrComm);
		assertTrue(attrComm.getReplies().size()>0);
	}
	
	@Test
	void test_AttractionComment_User_ManyToOne_mapping() {
		assertNotNull(attrComm);
		assertEquals("admin" ,attrComm.getUser().getUsername());
	}

}
