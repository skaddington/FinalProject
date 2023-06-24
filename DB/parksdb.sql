-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema parksdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `parksdb` ;

-- -----------------------------------------------------
-- Schema parksdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `parksdb` DEFAULT CHARACTER SET utf8 ;
USE `parksdb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(250) NOT NULL,
  `enabled` TINYINT NOT NULL,
  `role` VARCHAR(45) NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `image_url` VARCHAR(2000) NULL,
  `description` TEXT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `park` ;

CREATE TABLE IF NOT EXISTS `park` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  `date_established` DATE NOT NULL,
  `description` TEXT NOT NULL,
  `image_url` VARCHAR(2000) NULL,
  `website_url` VARCHAR(2000) NULL,
  `street` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `zip` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `activity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `activity` ;

CREATE TABLE IF NOT EXISTS `activity` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `image_url` VARCHAR(2000) NULL,
  `enabled` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `park_comment` ;

CREATE TABLE IF NOT EXISTS `park_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `park_id` INT NOT NULL,
  `content` TEXT NOT NULL,
  `reply_to_id` INT NULL,
  `created_at` DATETIME NULL,
  `enabled` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user-comment_user1_idx` (`user_id` ASC),
  INDEX `fk_user-comment_park1_idx` (`park_id` ASC),
  INDEX `fk_user_comment_user_comment1_idx` (`reply_to_id` ASC),
  CONSTRAINT `fk_user-comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user-comment_park1`
    FOREIGN KEY (`park_id`)
    REFERENCES `park` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_comment_user_comment1`
    FOREIGN KEY (`reply_to_id`)
    REFERENCES `park_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `attraction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attraction` ;

CREATE TABLE IF NOT EXISTS `attraction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `image_url` VARCHAR(2000) NULL,
  `website_url` VARCHAR(2000) NULL,
  `enabled` TINYINT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `park_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_local_recommendation_park1_idx` (`park_id` ASC),
  INDEX `fk_local_recommendation_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_local_recommendation_park1`
    FOREIGN KEY (`park_id`)
    REFERENCES `park` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_local_recommendation_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park_has_activity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `park_has_activity` ;

CREATE TABLE IF NOT EXISTS `park_has_activity` (
  `park_id` INT NOT NULL,
  `activity_id` INT NOT NULL,
  PRIMARY KEY (`park_id`, `activity_id`),
  INDEX `fk_park_has_activity_activity1_idx` (`activity_id` ASC),
  INDEX `fk_park_has_activity_park1_idx` (`park_id` ASC),
  CONSTRAINT `fk_park_has_activity_park1`
    FOREIGN KEY (`park_id`)
    REFERENCES `park` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_park_has_activity_activity1`
    FOREIGN KEY (`activity_id`)
    REFERENCES `activity` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park_photo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `park_photo` ;

CREATE TABLE IF NOT EXISTS `park_photo` (
  `id` INT NOT NULL,
  `park_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `image_url` VARCHAR(2000) NOT NULL,
  `image_date` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_photo_gallery_park1_idx` (`park_id` ASC),
  INDEX `fk_photo_gallery_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_photo_gallery_park1`
    FOREIGN KEY (`park_id`)
    REFERENCES `park` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_photo_gallery_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `state` ;

CREATE TABLE IF NOT EXISTS `state` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `abbreviation` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park_has_state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `park_has_state` ;

CREATE TABLE IF NOT EXISTS `park_has_state` (
  `park_id` INT NOT NULL,
  `state_id` INT NOT NULL,
  PRIMARY KEY (`park_id`, `state_id`),
  INDEX `fk_park_has_state_state1_idx` (`state_id` ASC),
  INDEX `fk_park_has_state_park1_idx` (`park_id` ASC),
  CONSTRAINT `fk_park_has_state_park1`
    FOREIGN KEY (`park_id`)
    REFERENCES `park` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_park_has_state_state1`
    FOREIGN KEY (`state_id`)
    REFERENCES `state` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_favorites`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_favorites` ;

CREATE TABLE IF NOT EXISTS `user_favorites` (
  `user_id` INT NOT NULL,
  `park_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `park_id`),
  INDEX `fk_user_has_park_park1_idx` (`park_id` ASC),
  INDEX `fk_user_has_park_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_park_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_park_park1`
    FOREIGN KEY (`park_id`)
    REFERENCES `park` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `park_rating` ;

CREATE TABLE IF NOT EXISTS `park_rating` (
  `user_id` INT NOT NULL,
  `park_id` INT NOT NULL,
  `rating` INT NOT NULL,
  `rating_comment` TEXT NULL,
  `rating_date` DATETIME NULL,
  PRIMARY KEY (`user_id`, `park_id`),
  INDEX `fk_user_has_park_park2_idx` (`park_id` ASC),
  INDEX `fk_user_has_park_user2_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_park_user2`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_park_park2`
    FOREIGN KEY (`park_id`)
    REFERENCES `park` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `attraction_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attraction_comment` ;

CREATE TABLE IF NOT EXISTS `attraction_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `content` TEXT NOT NULL,
  `reply_to_id` INT NULL,
  `created_at` DATETIME NULL,
  `attraction_id` INT NOT NULL,
  `enabled` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user-comment_user1_idx` (`user_id` ASC),
  INDEX `fk_user_comment_user_comment1_idx` (`reply_to_id` ASC),
  INDEX `fk_attraction_comment_attraction1_idx` (`attraction_id` ASC),
  CONSTRAINT `fk_user-comment_user10`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_comment_user_comment10`
    FOREIGN KEY (`reply_to_id`)
    REFERENCES `attraction_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_attraction_comment_attraction1`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `attraction` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `attraction_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attraction_rating` ;

CREATE TABLE IF NOT EXISTS `attraction_rating` (
  `user_id` INT NOT NULL,
  `rating` INT NOT NULL,
  `rating_comment` TEXT NULL,
  `rating_date` DATETIME NULL,
  `attraction_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `attraction_id`),
  INDEX `fk_user_has_park_user2_idx` (`user_id` ASC),
  INDEX `fk_attraction_rating_attraction1_idx` (`attraction_id` ASC),
  CONSTRAINT `fk_user_has_park_user20`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_attraction_rating_attraction1`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `attraction` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS park@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'park'@'localhost' IDENTIFIED BY 'park';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'park'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `description`, `created_at`, `updated_at`) VALUES (1, 'admin', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, 'ADMIN', 'Ranger', 'Smith', 'https://akroncantonjellystone.com/wp-content/uploads/2022/02/136RANGERBU17083_CA_YOGI-L.png', '\"Bears are supposed to avoid people, not run around stealing their food!\"', NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `description`, `created_at`, `updated_at`) VALUES (2, 'visitor1', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, 'BASIC', 'Yogi', 'Bear', 'https://upload.wikimedia.org/wikipedia/en/f/f0/Yogi_Bear_Yogi_Bear.png', '\"Would ya just look at that \'pic-a-nic\' basket!\"', NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `description`, `created_at`, `updated_at`) VALUES (3, 'visitor2', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, 'BASIC', 'Boo Boo', 'Bear', 'https://upload.wikimedia.org/wikipedia/en/4/4c/Boo-Boo_Bear.png', '\"Mr. Ranger isn\'t gonna like this, Yogi.\"', NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `description`, `created_at`, `updated_at`) VALUES (4, 'visitor3', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, 'BASIC', 'Rocky', 'Squirrel', 'https://upload.wikimedia.org/wikipedia/en/thumb/3/37/Rocket_J._Squirrel.png/250px-Rocket_J._Squirrel.png', 'Referred to as the \'Jet Age aerial ace.\' \"Hokey Smoke!\"', NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `description`, `created_at`, `updated_at`) VALUES (5, 'visitor4', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, 'BASIC', 'Bullwinkle', 'Moose', 'https://upload.wikimedia.org/wikipedia/en/c/c2/Bullwinke_J._Moose.png', 'Known for his \'mighty moose muscle,\' and the ability to remember every single thing he ever ate. \"Nothing up my sleeve...Presto.\"', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `park`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (1, 'Acadia National Park', '1919-02-26', 'Acadia National Park is located on Mount Desert Island in Maine. It offers stunning landscapes, rocky shores, and diverse wildlife.', 'https://www.travelcaffeine.com/wp-content/uploads/2013/10/DSC_6123-as-Smart-Object-1-copy.jpg', 'https://www.nps.gov/acad/', '25 Visitor Center Road', 'Bar Harbor', 'ME', '4609');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (2, 'American Samoa National Park', '1988-10-31', 'American Samoa National Park is spread across three islands: Tutuila, Ofu, and Tau. It preserves the unique South Pacific ecosystem and cultural heritage of the Samoan people.', 'https://static.wixstatic.com/media/afa439_e1efe89c685c45c49a8a2b29bf7971b9~mv2.jpg/v1/fill/w_640,h_382,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/afa439_e1efe89c685c45c49a8a2b29bf7971b9~mv2.jpg', 'https://www.nps.gov/npsa/', 'National Park of American Samoa', 'Pago Pago', 'AS', '96799');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (3, 'Arches National Park', '1971-11-12', 'Arches National Park in Utah is famous for its natural sandstone arches, including the iconic Delicate Arch. It offers stunning geological formations and hiking opportunities.', 'https://thewildimages.com/wp-content/uploads/2021/10/Photo-3706.jpg', 'https://www.nps.gov/arch/', 'PO Box 907', 'Moab', 'UT', '84532');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (4, 'Badlands National Park', '1978-11-10', 'Badlands National Park in South Dakota features rugged landscapes, colorful rock formations, and abundant wildlife. It provides visitors with unique geological and paleontological experiences.', 'https://i.natgeofe.com/n/bf3d2abd-480d-45d7-9c27-7267c7535d53/h_00000221060151.jpg?w=2880&h=1942', 'https://www.nps.gov/badl/', '25216 Ben Reifel Road', 'Interior', 'SD', '57750');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (5, 'Big Bend National Park', '1944-06-12', 'Big Bend National Park in Texas is characterized by its vast desert landscapes, deep canyons, and the winding Rio Grande. It offers diverse flora and fauna, as well as opportunities for hiking, camping, and stargazing.', 'https://www.imagesfromtexas.com/images/xl/Big-Bend---Bluebonnets-and-a-Rainbow.jpg', 'https://www.nps.gov/bibe/', '1 Panther Drive', 'Big Bend National Park', 'TX', '79834');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (6, 'Biscayne National Park', '1980-06-28', 'Biscayne National Park in Florida protects a unique marine ecosystem that includes coral reefs, islands, and shoreline. It offers opportunities for boating, snorkeling, and scuba diving.', 'https://ik.imagekit.io/grgdihc3l/getmedia/01a4a1aa-b6c1-45e9-80b5-4139f9cff4bb/Boca_Chita_lighthouse_1440x900.aspx?width=570&height=356', 'https://www.nps.gov/bisc/', '9700 SW 328th Street', 'Homestead', 'FL', '33033');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (7, 'Black Canyon of the Gunnison National Park', '1999-10-21', 'Black Canyon of the Gunnison National Park in Colorado is known for its dramatic vertical cliffs and deep, narrow canyon. It offers breathtaking views and opportunities for hiking and rock climbing.', 'https://cdn2.picryl.com/photo/2014/01/01/rainbow-in-the-canyon-black-canyon-of-the-gunnison-national-park-2014-24687c-640.jpg', 'https://www.nps.gov/blca/', '102 Elk Creek', 'Gunnison', 'CO', '81230');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (8, 'Bryce Canyon National Park', '1928-02-25', 'Bryce Canyon National Park in Utah features a collection of unique geological structures known as hoodoos. It offers scenic viewpoints, hiking trails, and stargazing opportunities.', 'https://c4.wallpaperflare.com/wallpaper/348/563/647/white-and-red-lighthouse-near-gray-sand-during-daytime-wallpaper-preview.jpg', 'https://www.nps.gov/brca/', 'PO Box 640201', 'Bryce Canyon City', 'UT', '84764');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (9, 'Canyonlands National Park', '1964-09-12', 'Canyonlands National Park in Utah is characterized by its rugged canyons, towering mesas, and the convergence of the Green and Colorado Rivers. It offers diverse outdoor activities and breathtaking vistas.', 'https://i0.wp.com/mishmoments.com/wp-content/uploads/2019/10/canyonlands-island-in-the-sky-murphy-point-2.jpg?fit=600%2C900&ssl=1', 'https://www.nps.gov/cany/', '2282 Resource Blvd', 'Moab', 'UT', '84532');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (10, 'Capitol Reef National Park', '1971-12-18', 'Capitol Reef National Park in Utah showcases colorful sandstone cliffs, natural bridges, and unique geological formations. It offers hiking trails, camping sites, and opportunities to explore its rich history.', 'https://images.fineartamerica.com/images/artworkimages/mediumlarge/1/a-near-perfect-rainbow-over-capitol-reef-national-park-yinguo-huang.jpg', 'https://www.nps.gov/care/', '52 West Headquarters Drive', 'Torrey', 'UT', '84775');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (11, 'Carlsbad Caverns National Park', '1930-05-14', 'Carlsbad Caverns National Park in New Mexico is famous for its stunning underground cave system. It offers guided tours, bat flights, and opportunities for spelunking.', 'https://c4.wallpaperflare.com/wallpaper/415/852/887/carlsbad-caverns-national-park-new-mexico-wallpaper-preview.jpg', 'https://www.nps.gov/cave/', '727 Carlsbad Caverns Highway', 'Carlsbad', 'NM', '88220');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (12, 'Channel Islands National Park', '1980-03-05', 'Channel Islands National Park in California consists of five islands and their surrounding waters. It is home to diverse ecosystems, unique plant species, and archaeological sites.', 'https://campsitephotos.com/wp/wp-content/uploads/2019/11/Channel-Islands-National-Park.png', 'https://www.nps.gov/chis/', '1901 Spinnaker Drive', 'Ventura', 'CA', '93001');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (13, 'Congaree National Park', '2003-11-10', 'Congaree National Park in South Carolina protects one of the largest intact expanses of old-growth bottomland hardwood forest in the southeastern United States. It offers hiking, kayaking, and nature-watching opportunities.', 'https://i.pinimg.com/originals/f5/0b/c2/f50bc2323cc65c9cb84c0e01a0657746.jpg', 'https://www.nps.gov/cong/', '100 National Park Road', 'Hopkins', 'SC', '29061');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (14, 'Crater Lake National Park', '1902-05-22', 'Crater Lake National Park in Oregon is renowned for its deep blue lake formed within a volcanic caldera. It offers scenic viewpoints, hiking trails, and opportunities for boating and fishing.', 'https://e0.pxfuel.com/wallpapers/793/204/desktop-wallpaper-double-rainbow-at-crater-lake-national-park-southern-oregon-landscape-clouds-sky-usa.jpg', 'https://www.nps.gov/crla/', 'PO Box 7', 'Crater Lake', 'OR', '97604');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (15, 'Cuyahoga Valley National Park', '2000-10-11', 'Cuyahoga Valley National Park in Ohio is a green oasis along the Cuyahoga River, offering a combination of natural beauty, cultural landscapes, and recreational opportunities.', 'https://upload.wikimedia.org/wikipedia/commons/e/ea/Cuyahoga_Valley_National_Park_19.jpg', 'https://www.nps.gov/cuva/', '15610 Vaughn Road', 'Brecksville', 'OH', '44141');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (16, 'Death Valley National Park', '1994-10-31', 'Death Valley National Park in California and Nevada is known for its extreme desert landscapes, canyons, and salt flats. It offers hiking trails, scenic drives, and unique geological formations.', 'https://www.piscoandbier.com/wp-content/uploads/2020/12/artists-palette-death-valley-national-park.jpg-773x966.jpg', 'https://www.nps.gov/deva/', 'PO Box 579', 'Death Valley', 'CA', '92328');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (17, 'Denali National Park and Preserve', '1917-02-26', 'Denali National Park and Preserve in Alaska is home to Denali, North America\'s highest peak. It offers vast wilderness, abundant wildlife, and opportunities for hiking, camping, and mountaineering.', 'https://www.photoshelter.com/img-get/I00009NuDZBa9H50/s/720/479/Teklanika-rainbow.jpg', 'https://www.nps.gov/dena/', 'Mile 237 Parks Highway', 'Denali National Park', 'AK', '99755');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (18, 'Dry Tortugas National Park', '1992-10-26', 'Dry Tortugas National Park in Florida is located in the Gulf of Mexico and consists of seven islands. It is known for its crystal-clear waters, coral reefs, and historic Fort Jefferson.', 'https://www.westchasewow.com/wp-content/uploads/2022/09/Dry-Tortugas0922d-1024x768.jpg', 'https://www.nps.gov/drto/', '40001 SR-9336', 'Homestead', 'FL', '33034');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (19, 'Everglades National Park', '1934-05-30', 'Everglades National Park in Florida is the largest tropical wilderness in the United States. It is home to diverse ecosystems, including marshes, mangroves, and sawgrass prairies.', 'https://i.pinimg.com/736x/28/58/48/2858485a835b7ac90d3954dc7b1106b6--national-parks-grass.jpg', 'https://www.nps.gov/ever/', '40001 SR-9336', 'Homestead', 'FL', '33034');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (20, 'Gates of the Arctic National Park and Preserve', '1980-12-02', 'Gates of the Arctic National Park and Preserve in Alaska is a remote wilderness area located north of the Arctic Circle. It offers untouched landscapes, pristine rivers, and opportunities for backpacking and wildlife viewing.', 'https://arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/KETML4BQDUI6ZABWPWZFLP7ROY.jpg', 'https://www.nps.gov/gaar/', '4175 Geist Road', 'Fairbanks', 'AK', '99709');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (21, 'Glacier National Park', '1910-05-11', 'Glacier National Park in Montana is known for its stunning glaciers, pristine lakes, and rugged mountains. It offers breathtaking scenery, hiking trails, and opportunities for camping and wildlife spotting.', 'https://pbs.twimg.com/media/FOEs8qLXsA8Nv5J?format=jpg&name=4096x4096', 'https://www.nps.gov/glac/', '64 Grinnell Drive', 'West Glacier', 'MT', '59936');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (22, 'Glacier Bay National Park and Preserve', '1980-12-02', 'Glacier Bay National Park and Preserve in Alaska is a unique marine wilderness area. It features tidewater glaciers, fjords, and a rich variety of marine and terrestrial wildlife.', 'https://www.shutterstock.com/image-photo/beautiful-panoramic-view-margerie-glacier-260nw-1852972807.jpg', 'https://www.nps.gov/glba/', '1 Park Road', 'Gustavus', 'AK', '99826');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (23, 'Grand Canyon National Park', '1919-02-26', 'Grand Canyon National Park in Arizona is one of the world\'s most iconic natural wonders. It offers awe-inspiring views, hiking trails, and opportunities for rafting along the Colorado River.', 'https://www.mygrandcanyonpark.com/wp-content/uploads/2009/05/GC-Rainbow-PimaPoint_NPSMichaelQuinn_2400.jpg', 'https://www.nps.gov/grca/', '20 South Entrance Road', 'Grand Canyon', 'AZ', '86023');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (25, 'Great Basin National Park', '1986-10-27', 'Great Basin National Park in Nevada is a rugged and isolated area featuring ancient bristlecone pine groves, limestone caves, and the impressive Lehman Caves. It offers hiking trails and stargazing opportunities.', 'https://national-park.com/wp-content/uploads/2016/04/Welcome-to-Great-Basin-National-Park.jpg', 'https://www.nps.gov/grba/', '100 Great Basin National Park', 'Baker', 'NV', '89311');

COMMIT;


-- -----------------------------------------------------
-- Data for table `activity`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (1, 'Hiking', 'Explore scenic trails through the forest and enjoy breathtaking views of the surrounding landscape.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (2, 'Wildlife Viewing', 'Observe the park\'s diverse wildlife, including birds, mammals, and reptiles.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (3, 'Camping', 'Set up camp and enjoy a night under the stars.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (4, 'Picnicking', 'Have a relaxing picnic in designated areas with beautiful views.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (5, 'Photography', 'Capture the park\'s natural beauty through your lens.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (6, 'Fishing', 'Try your luck at fishing in the park\'s rivers or lakes.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (7, 'Canoeing/Kayaking', 'Paddle along the park\'s waterways for a unique perspective.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (8, 'Rock Climbing', 'Challenge yourself on the park\'s rock formations and cliffs.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (9, 'Guided Tours', 'Join a guided tour to learn more about the park\'s history and ecology.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (10, 'Star Gazing', 'Experience the wonders of the night sky. Away from city lights, national parks offer excellent opportunities for stargazing and astrophotography.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (11, 'Ranger Programs', 'Participate in ranger-led programs and activities for both adults and children. Learn about nature, conservation, and park ecosystems.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (12, 'Scenic Drives', 'Take a scenic drive through the park\'s picturesque roads. Enjoy breathtaking views from the comfort of your vehicle.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (13, 'Biking', 'Explore the park on two wheels by cycling through designated bike paths or off-road trails. Enjoy the thrill of biking in a natural setting.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (14, 'WildFlower Viewing', 'During the blooming season, witness the park\'s vibrant wildflowers. Discover beautiful displays of colors and learn about native flora.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (15, 'Geocaching', 'Embark on a high-tech treasure hunt using GPS coordinates. Geocaching allows you to explore the park while searching for hidden caches.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (16, 'Junior Ranger Programs', 'Engage children in the park\'s Junior Ranger Program. Kids can complete activities and earn badges while learning about nature and conservation.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (17, 'Rafting', 'Experience the thrill of white-water rafting in designated areas of the park. Join guided tours for an adrenaline-pumping adventure.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (18, 'Paddling', 'Rent a stand-up paddleboard or a pedal boat to explore calm waters within the park. Enjoy a leisurely water activity with friends or family.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (19, 'Wilderness BackPacking', 'Embark on multi-day backpacking trips through the park\'s wilderness. Explore remote areas and camp in pristine natural surroundings.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (20, 'Photography Workshops', 'Join photography workshops led by professionals. Learn new techniques and capture the park\'s beauty from unique perspectives.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (21, 'Horseback Riding', 'Saddle up and ride through designated trails on horseback. Enjoy a leisurely ride while taking in the natural wonders of the park.', '', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (22, 'Interpretive Centers', 'Visit interpretive centers within the park to learn about its history, geology, and wildlife through interactive exhibits and displays.', '', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `park_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `park_comment` (`id`, `user_id`, `park_id`, `content`, `reply_to_id`, `created_at`, `enabled`) VALUES (1, 1, 1, 'test. sample delete me', NULL, '2023-02-02', 1);
INSERT INTO `park_comment` (`id`, `user_id`, `park_id`, `content`, `reply_to_id`, `created_at`, `enabled`) VALUES (2, 1, 2, 'delete it!', NULL, '2023-01-01', 1);
INSERT INTO `park_comment` (`id`, `user_id`, `park_id`, `content`, `reply_to_id`, `created_at`, `enabled`) VALUES (3, 2, 1, 'hey you got some data!', 1, '2023-01-01', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `attraction`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (1, 'burgerplace', 'ahhhhhhhhhhhhh', NULL, NULL, NULL, NULL, NULL, 1, 1);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (2, 'testing', 'patrick was here', NULL, NULL, NULL, NULL, NULL, 1, 1);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (3, 'the', 'game', NULL, NULL, NULL, NULL, NULL, 1, 1);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (4, 'you', 'lost', NULL, NULL, NULL, NULL, NULL, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `park_has_activity`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (1, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (1, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (1, 3);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (1, 4);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `park_photo`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (1, 1, 1, 'https://images.unsplash.com/photo-1519331379826-f10be5486c6f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGFya3xlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80', NULL);
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (2, 1, 1, 'https://images.unsplash.com/photo-1519331379826-f10be5486c6f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGFya3xlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80', NULL);
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (3, 1, 1, 'https://images.unsplash.com/photo-1519331379826-f10be5486c6f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGFya3xlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `state`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (1, 'AL', 'Alabama');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (2, 'AK', 'Alaska');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (3, 'AZ', 'Arizona');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (4, 'AR', 'Arkansas');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (5, 'CA', 'California');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (6, 'CO', 'Colorado');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (7, 'CT', 'Connecticut');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (8, 'DE', 'Delaware');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (9, 'FL', 'Florida');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (10, 'GA', 'Georgia');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (11, 'HI', 'Hawaii');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (12, 'ID', 'Idaho');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (13, 'IL', 'Illinois');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (14, 'IN', 'Indiana');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (15, 'IA', 'Iowa');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (16, 'KS', 'Kansas');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (17, 'KY', 'Kentucky');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (18, 'LA', 'Lousiana');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (19, 'ME', 'Maine');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (20, 'MD', 'Maryland');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (21, 'MA', 'Massachusetts');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (22, 'MI', 'Michigan');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (23, 'MN', 'Minnesota');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (24, 'MS', 'Mississippi');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (25, 'MO', 'Missouri');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (26, 'MT', 'Montana');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (27, 'NE', 'Nebraska');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (28, 'NV', 'Nevada');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (29, 'NH', 'New Hampshire');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (30, 'NJ', 'New Jersey');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (31, 'NM', 'New Mexico');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (32, 'NY', 'New York');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (33, 'NC', 'North Carolina');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (34, 'ND', 'North Dakota');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (35, 'OH', 'Ohio');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (36, 'OK', 'Oklahoma');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (37, 'OR', 'Oregon');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (38, 'PA', 'Pennslyvania');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (39, 'RI', 'Rhode Island');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (40, 'SC', 'South Carolina');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (41, 'TN', 'Tennessee');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (42, 'TX', 'Texas');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (43, 'SD', 'South Dakota');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (44, 'UT', 'Utah');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (45, 'VT', 'Varmont');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (46, 'VA', 'Virginia');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (47, 'WA', 'Washington');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (48, 'WV', 'West Virgina');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (49, 'WI', 'Wisconsin');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (50, 'WY', 'Wyoming');

COMMIT;


-- -----------------------------------------------------
-- Data for table `park_has_state`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (1, 1);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (2, 2);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (3, 3);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (4, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_favorites`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (1, 1);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (1, 2);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (1, 3);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (1, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `park_rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `park_rating` (`user_id`, `park_id`, `rating`, `rating_comment`, `rating_date`) VALUES (1, 1, 4, 'messin with the wildlife,,,,, that\'s a paddlin', NULL);
INSERT INTO `park_rating` (`user_id`, `park_id`, `rating`, `rating_comment`, `rating_date`) VALUES (2, 1, 1, 'Some jerkoff beat me with a paddle!', NULL);
INSERT INTO `park_rating` (`user_id`, `park_id`, `rating`, `rating_comment`, `rating_date`) VALUES (3, 2, 3, 'Self-Destruct activated', NULL);
INSERT INTO `park_rating` (`user_id`, `park_id`, `rating`, `rating_comment`, `rating_date`) VALUES (4, 3, 2, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `attraction_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `attraction_comment` (`id`, `user_id`, `content`, `reply_to_id`, `created_at`, `attraction_id`, `enabled`) VALUES (1, 1, 'idk what to put here', NULL, NULL, 1, 1);
INSERT INTO `attraction_comment` (`id`, `user_id`, `content`, `reply_to_id`, `created_at`, `attraction_id`, `enabled`) VALUES (2, 2, 'all out of ideas', NULL, NULL, 1, 1);
INSERT INTO `attraction_comment` (`id`, `user_id`, `content`, `reply_to_id`, `created_at`, `attraction_id`, `enabled`) VALUES (3, 1, 'ahhh', NULL, NULL, 1, 1);
INSERT INTO `attraction_comment` (`id`, `user_id`, `content`, `reply_to_id`, `created_at`, `attraction_id`, `enabled`) VALUES (4, 3, 'aadw', 2, NULL, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `attraction_rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 2, 'testdata', '2013-12-01', 1);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 3, 'more testdata', '2023-05-01', 2);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 2, 'im out of ideas on what too put....', '2017-05-03', 3);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 1, 'still got nothin.', '2021-12-12', 4);

COMMIT;

