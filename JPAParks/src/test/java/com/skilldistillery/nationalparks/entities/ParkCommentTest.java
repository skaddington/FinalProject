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

class ParkCommentTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private ParkComment parkComm;

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
		parkComm = em.find(ParkComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		parkComm = null;
	}

	@Test
	void test_ParkComment_basic_mapping() {
		assertNotNull(parkComm);
		assertEquals("test. sample delete me", parkComm.getContent());
	}
	
	@Test
	void test_ParkComment_Park_ManyToOne_mapping() {
		assertNotNull(parkComm);
		assertEquals(1, parkComm.getPark().getId());
	}
	
	@Test
	void test_ParkComment_User_ManyToOne_mapping() {
		assertNotNull(parkComm);
		assertEquals(1, parkComm.getUser().getId());
	}
	
	@Test
	void test_ParkComment_ParkCommentReply_OneToMany_mapping() {
		assertNotNull(parkComm);
		assertTrue(parkComm.getReplies().size()>0);
	}


}
