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

class ParkPhotoTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private ParkPhoto photo;

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
		photo = em.find(ParkPhoto.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		photo = null;
	}

	@Test
	void test_ParkPhoto_basic_mapping() {
		assertNotNull(photo);
		assertNotNull(photo.getImage());
	}

}
