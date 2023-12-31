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

class StateTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private State state;

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
		state = em.find(State.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		state = null;
	}

	@Test
	void test_State_basic_mapping() {
		assertNotNull(state);
		assertEquals("Alabama", state.getName());
	}
	
	@Test
	void test_State_Park_ManyToMany_mapping() {
		assertNotNull(state);
		assertTrue(state.getParks().size()>0);
	}

}
