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
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `description`, `created_at`, `updated_at`) VALUES (1, 'admin', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, 'ADMIN', 'Ranger', 'Smith', 'https://akroncantonjellystone.com/wp-content/uploads/2022/02/136RANGERBU17083_CA_YOGI-L.png', '\"Bears are supposed to avoid people, not run around stealing their food!\"', '1932-10-04', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `description`, `created_at`, `updated_at`) VALUES (2, 'visitor1', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, 'BASIC', 'Yogi', 'Bear', 'https://upload.wikimedia.org/wikipedia/en/f/f0/Yogi_Bear_Yogi_Bear.png', '\"Would ya just look at that \'pic-a-nic\' basket!\"', '1932-10-05', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `description`, `created_at`, `updated_at`) VALUES (3, 'visitor2', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, 'BASIC', 'Boo Boo', 'Bear', 'https://upload.wikimedia.org/wikipedia/en/4/4c/Boo-Boo_Bear.png', '\"Mr. Ranger isn\'t gonna like this, Yogi.\"', '1932-10-5', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `description`, `created_at`, `updated_at`) VALUES (4, 'visitor3', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, 'BASIC', 'Rocky', 'Squirrel', 'https://upload.wikimedia.org/wikipedia/en/thumb/3/37/Rocket_J._Squirrel.png/250px-Rocket_J._Squirrel.png', 'Referred to as the \'Jet Age aerial ace.\' \"Hokey Smoke!\"', '1959-11-01', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `description`, `created_at`, `updated_at`) VALUES (5, 'visitor4', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, 'BASIC', 'Bullwinkle', 'Moose', 'https://upload.wikimedia.org/wikipedia/en/c/c2/Bullwinke_J._Moose.png', 'Known for his \'mighty moose muscle,\' and the ability to remember every single thing he ever ate. \"Nothing up my sleeve...Presto.\"', '1959-11-01', NULL);

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
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (23, 'Grand Canyon National Park', '1919-02-26', 'Grand Canyon National Park in Arizona is one of the world\'s most iconic natural wonders. It offers awe-inspiring views, hiking trails, and opportunities for rafting along the Colorado River.', 'https://www.mygrandcanyonpark.com/wp-content/uploads/2009/05/GC-Rainbow-PimaPoint_NPSMichaelQuinn_2400.jpg', 'https://www.nps.gov/grca/index.htm', '20 South Entrance Road', 'Grand Canyon', 'AZ', '86023');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (24, 'Great Basin National Park', '1986-10-27', 'Great Basin National Park in Nevada is a rugged and isolated area featuring ancient bristlecone pine groves, limestone caves, and the impressive Lehman Caves. It offers hiking trails and stargazing opportunities.', 'https://national-park.com/wp-content/uploads/2016/04/Welcome-to-Great-Basin-National-Park.jpg', 'https://www.nps.gov/grba/', '100 Great Basin National Park', 'Baker', 'NV', '89311');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (25, 'Grand Teton National Park', '1929-02-26', 'Grand Teton National Park in Wyoming ten peaks including Grand Teton formed by glaciation, with lakes and rivers that extend beyond the park into neighboring Yellowstone National Park. Ample hiking and mountain climing opportunities.', 'https://external-preview.redd.it/IkwqXFzUlnhVVRsNxc6h2dG8Nquyky8q2f3ATP3jTGg.jpg?auto=webp&s=b4639ce6c53166de61212a7a6050a78b2b834dd5', 'https://www.nps.gov/grte/index.htm', 'P.O. Box 170', 'Moose', 'WY', '83012');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (26, 'Great Sand Dunes National Park and Preserve', '2004-09-24', 'The Great Sand Dunes National Park and Preserve in Colorado has the tallest dunes in North America, diverse landscape of grasslands, wetlands, forests, alpine lakes, and tundra. and stargazing by night. ', 'https://images.squarespace-cdn.com/content/v1/5d23c7f86411800001a8a97a/e46ef9e1-6a56-4ed6-95e8-68f0591e5a4a/P1110360.jpg', 'https://www.nps.gov/grsa/index.htm', '11999 State Highway 150', 'Mosca', 'CO', '81146');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (27, 'Great Smoky Mountains National Park', '1934-06-15', 'Great Smokey Mountains borders between North Carolina and Tennessee with a great diversity of wildlife and plant life with the Southern Appalachian mountain culture.', 'https://images.fineartamerica.com/images/artworkimages/mediumlarge/1/a-rainbow-cascade-john-rowe.jpg', 'https://www.nps.gov/grsm/index.htm', '107 Park Headquarters Road', 'Gatlinburg', 'TN', '37738');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (28, 'Guadalupe Mountains National Park', '1972-09-30', 'Guadalupe Mountains in Texas has not only Mountains, but canyons, desert and dunes offering opportunity for stargazing, explore fossil reef and a diverse flora and fauna.', 'https://c4.wallpaperflare.com/wallpaper/937/111/649/yucca-plants-guadalupe-mountains-n-p-texas-wallpaper-preview.jpg', 'https://www.nps.gov/gumo/index.htm', '400 Pine Canyon', 'Salt Flat', 'TX', '79847');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (29, 'Haleakala National Park', '1961-07-01', 'Haleakala in Hawaii is a rare and sacred landscape, home to many endangered species, with stark volcanic landscapes and sub-tropical rain forest.', 'https://www.nps.gov/articles/images/hale-main.jpg?maxwidth=650&autorotate=false', 'https://www.nps.gov/hale/index.htm', 'PO Box 369', 'Makawao', 'HI', '96768');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (30, 'Hawaii Volcanoes National Park', '1916-08-01', 'Hawaii Volcanoes National Park protects the most unique geological, biological, and cultural landscapes in the world. Including two of the world\'s most active volcanoes.', 'https://images.squarespace-cdn.com/content/v1/571c296d22482efa17890ad9/1634943572411-F9Y9UIN616UNB2AKN6VE/IMG_C2BC44F1B043-1.jpeg?format=1500w', 'https://www.nps.gov/havo/index.htm', 'PO Box 52', 'Hawaii National Park', 'HI', '96718');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (31, 'Hot Springs National Park', '1921-03-04', 'Hot Springs National Park in Arkansas is where history and nature meet with natural curiosities. Ancient thermal springs, mountain views, forested hikes, and abundant creeks.', 'https://lp-cms-production.imgix.net/2020-11/shutterstockRF_295450106.jpg?auto=format&w=1440&h=810&fit=crop&q=75', 'https://www.nps.gov/hosp/index.htm', '101 Reserve Street', 'Hot Springs', 'AR', '71901');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (32, 'Indiana Dunes National Park', '2019-02-15', 'Indianan Dunes in Indiana through shifting sand dunes, woodlands, prairies, and wetlands.', 'https://cdn.aarp.net/content/dam/aarp/travel/Domestic/2021/07/1140-indiana-dunes-national-park.jpg', 'https://www.nps.gov/indu/index.htm', '1100 North Mineral Springs Road ', 'Porter', 'IN', '46304');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (33, 'Isle Royale National Park', '1940-04-03', 'Isle Royale in Michigan great for backpackers, hikers, boaters, paddlers, and divers at this island.', 'https://www.nps.gov/isro/images/ISRO_Web_Brown-Paul_North-Government-Island_Aerial_960x638.jpg?maxwidth=1300&autorotate=false', 'https://www.nps.gov/isro/index.htm', '800 East Lakeshore Drive', 'Houghton', 'MI', '49931');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (34, 'Joshua Tree National Park', '1994-10-31', 'Joshua Tree in California is where the Mojave and the Colorado desert ecosystems with variety of plants and animals.', 'https://th-thumbnailer.cdn-si-edu.com/-PnrFyMjCuG6rFSnxQlf3wsr54k=/fit-in/1072x0/https://tf-cmsv2-photocontest-smithsonianmag-prod-approved.s3.amazonaws.com/a84ac0de0f1fb5b9dfde0000b7dbe6183d4ff222.jpg', 'https://www.nps.gov/jotr/index.htm', '74485 National Park Drive', 'Twentynine Palms', 'CA', '92277');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (35, 'Katmai National Park and Preserve', '1980-12-02', 'Katmai in Alaska is a volcanically devastated region surrounding Novarupta and the Valley of Ten Thousand Smokes.', 'https://pbs.twimg.com/media/DsD3FKjUUAIL3Iq.jpg:large', 'https://www.nps.gov/katm/index.htm', 'PO Box 7', 'King Salmon', 'AK', '99613');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (36, 'Kenai Fjords National Park', '1980-12-02', 'Kenai Fjords in Alaska on the edge of the Kenai Peninsula where nearly 40 glaciers flow from the Harding Icefield.', 'https://www.travelandleisure.com/thmb/oRRDxvRie8-HRpw26Nb5N31uPZk=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/kenai-fjords-ice-boarder-KENAI0520-eae0e03e608c4675b337da3681113d56.jpg', 'https://www.nps.gov/kefj/index.htm', 'PO Box 1727', 'Seward', 'AK', '99664');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (37, 'Kings Canyon National Park', '1940-03-04', 'Kings Canyon in California with mountains, foothills, canyons, caverns, and the world\'s largest trees.', 'https://i0.wp.com/epic7travel.com/wp-content/uploads/2022/10/Majestic-Mountain-Loop-Sequoia-Kings-Canyon-Yosemite.jpg?resize=1000%2C600&ssl=1', 'https://www.nps.gov/seki/index.htm', '47050 Generals Highway', 'Three Rivers', 'CA', '93271');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (38, 'Kobuk Valley National Park', '1980-12-02', 'Kobuk Valley in Alaska has Caribou, sand dunes, Kobuk River, Onion Portage.', 'https://www.nps.gov/im/arcn/images/caribou_swimming.jpg', 'https://www.nps.gov/kova/index.htm', 'PO Box 1029', 'Kotzebue', 'AK', '99752');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (39, 'Lake Clark National Park and Preserve', '1980-12-02', 'Lake Clark in Alaska Volcanoes steam, salmon run, bears forage, and craggy mountains with turquoise Lakes.', 'https://images.squarespace-cdn.com/content/v1/564d14dfe4b0290681184a82/1479828799715-8O6PRKZTNN52JRK0Q6WE/Lake+Clark+National+Park-014.jpg', 'https://www.nps.gov/lacl/index.htm', 'PO Box 227', 'Port Alsworth', 'AK', '99653');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (40, 'Lassen Volcanic National Park', '1916-08-09', 'Lassen Volcanic in California steaming fumaroles, meadows, mountain lakes, and volcanoes.', 'https://drupal8-prod.visitcalifornia.com/sites/drupal8-prod.visitcalifornia.com/files/styles/fluid_1200/public/vc_ca101_nationalparks_lassenvolcanic_manzanitalake_rf_628846294_1280x640.jpg?itok=XYUcaHpy', 'https://www.nps.gov/lavo/index.htm', 'PO Box 100', 'Mineral', 'CA', '96063');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (41, 'Mammoth Cave National Park', '1941-07-01', 'Mammoth Cave in Kentucky has hills, river valleys, and the world\'s largest known cave system.', 'https://www.nps.gov/articles/000/images/375EC6C7-1DD8-B71B-0B98F2E5334629F5Original.jpg?maxwidth=650&autorotate=false', 'https://www.nps.gov/maca/index.htm', 'PO Box 7', 'Mammoth Cave', 'KY', '42259');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (42, 'Mesa Verde National Park', '1906-06-29', 'Mesa Verde in Colorado protects the rich cultural heritage of 26 Pueblos and Tribes.', 'https://preview.redd.it/az1al20ecqc81.jpg?width=640&crop=smart&auto=webp&s=87d9c73f1680e8bfa03291091c3016b62610a79e', 'https://www.nps.gov/meve/index.htm', 'PO Box 8', 'Mesa Verde National Park', 'CO', '81330');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (43, 'Mount Rainier National Park', '1899-03-02', 'Mount Rainer in Washington is an active volcano and the most glaciated peak in the U.S.A., spawning five major rivers', 'https://c.ndtvimg.com/2022-09/2hior908_rainbow-ice-caves_625x300_06_September_22.jpg', 'https://www.nps.gov/mora/index.htm', '55210 238th Avenue East', 'Ashford', 'WA', '98304');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (44, 'New River Gorge National Park and Preserve', '2020-12-27', 'New River Gorge in West Virginia has whitewater river flowing north throughout deep canyons.', 'https://i.pinimg.com/originals/ce/57/c5/ce57c55f70790ef138baf729c6cb2172.jpg', 'https://www.nps.gov/neri/index.htm', 'PO Box 246', 'Glen Jean', 'WV', '25846');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (45, 'North Cascades National Park', '1968-10-02', 'North Cascades in Washington has more then 300 glaciers, cascading water, and forested valleys.', 'https://s27363.pcdn.co/wp-content/uploads/2020/09/Blue-Lake-Hike-North-Cascades.jpg.optimal.jpg', 'https://www.nps.gov/noca/index.htm', '810 State Route 20', 'Sedro-Woolley', 'WA', '98284');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (46, 'Olympic National Park', '1938-06-29', 'Olympic in Washington has mountains, wilderness, and several distinctly different ecosystems.', 'https://seattlemag.com/wp-content/uploads/2021/12/iStock-894567522-KatieDobies.jpg', 'https://www.nps.gov/olym/index.htm', '600 E. Park Avenue', 'Port Angeles', 'WA', '98362');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (47, 'Petrified Forest National Park', '1962-12-09', 'Petrified Forest in Arizona has trails, overlooks, labs, and hikes.', 'https://i0.wp.com/www.eastwestquest.com/wp-content/uploads/2018/02/Petrified_P3280692-2.jpg?resize=1024%2C757', 'https://www.nps.gov/pefo/index.htm', 'PO Box 2217', 'Petrified Forest', 'AZ', '86028');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (48, 'Pinnacles National Park', '2013-01-10', 'Pinnacles in California has had multiple volcanoes erupt, flowed, and slid to form Pinnacles National Park.', 'https://www.usatoday.com/gcdn/media/USATODAY/USATODAY/2013/05/30/1369970481004-XXX-SQUARE-BLOCK-RAINBOW-PINNACLES-NATIONAL-PARK-jy-7902-1305302326_16_9.jpg', 'https://www.nps.gov/pinn/index.htm', '5000 East Entrance Road', 'Paicines', 'CA', '95043');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (49, 'Redwood National Park', '1968-10-02', 'Redwood in California is protected prairies, woodlands, rivers, and coastline.', 'https://www.planetware.com/wpimages/2023/01/california-san-francisco-to-redwood-national-state-park-best-ways-to-get-there-by-plane-rainbow-jedediah-smith-redwoods.jpg', 'https://www.nps.gov/redw/index.htm', '1111 Second Street', 'Crescent City', 'CA', '95531');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (50, 'Rocky Mountain National Park', '1915-01-26', 'Rocky Mountain in Colorado has a range of mountain environments, meadows, and lakes.', 'https://www.nps.gov/common/uploads/cropped_image/primary/5863FE15-92C2-E7C3-9BA7C9267E0F128E.jpg?width=1600&quality=90&mode=crop', 'https://www.nps.gov/romo/index.htm', '1000 US Hwy 36', 'Estes Park', 'CO', '80517');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (51, 'Saguaro National Park', '1994-10-14', 'Saguaro in Arizona where the largest cacti, the giant saguaro, is only found in a small portion of the United States.', 'https://images.squarespace-cdn.com/content/v1/56c507817c65e4cf3f771fb6/1627773000419-0SRVNCT5F75PJ2FWWFHD/IMG_0361.JPG?format=1000w', 'https://www.nps.gov/sagu/index.htm', '3693 S Old Spanish Trail', 'Tucson', 'AZ', '85730');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (52, 'Sequoia National Park', '1890-09-25', 'Kings Canyon in California with mountains, foothills, canyons, caverns, and the world\'s largest trees.', 'https://www.visaliatimesdelta.com/gcdn/-mm-/0db0ac80146d892b7c004d14ca3b65331e5e208b/c=0-103-2000-1228/local/-/media/2016/07/15/Visalia/B9322970015Z.1_20160715224458_000_GIEF0QOBG.1-0.jpg?width=2000&height=1125&fit=crop&format=pjpg&auto=webp', 'https://www.nps.gov/seki/index.htm', '47050 Generals Highway', 'Three Rivers', 'CA', '93271');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (53, 'Shenandoah National Park', '1935-12-26', 'Shenandoah in Virginia has waterfalls, vistas, fields of wildflowers, and wooded hollows.', 'https://cdn.britannica.com/79/176979-050-DC64B229/Little-Stony-Man-Cliffs-Blue-Ridge-Mountains.jpg', 'https://www.nps.gov/shen/index.htm', '3655 U.S. Highway 211 East', 'Luray', 'VA', '22835');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (54, 'Theodore Roosevelt National Park', '1978-11-10', 'Theodore Roosevelt in North Dakota is a Dakota Territory in Honor of TR.', 'https://i.pinimg.com/736x/1a/56/5f/1a565f32d67882cd8e2624ce08fb3c20--theodore-roosevelt-national-park-north-dakota.jpg', 'https://www.nps.gov/thro/index.htm', 'PO Box 7', 'Medora', 'ND', '58645');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (55, 'Virgin Islands National Park', '1956-08-02', 'Virgin Islands in Virgin Islands is two-thirds St. Johns National park and a place to explore white-sand beaches and snorkel coral reefs.', 'https://www.bemytravelmuse.com/wp-content/uploads/2020/04/virgin-islands-national-park_what-to-do-and-how-to-get-there-14.jpg', 'https://www.nps.gov/viis/index.htm', '1300 Cruz Bay Creek', 'St John', 'VI', '830');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (56, 'Voyageurs National Park', '1975-04-08', 'Voyageurs in Minnesota is an adventure all year with rock ridges, cliffs, wetlands, forests, streams, and lakes.', 'https://morethanjustparks.com/wp-content/uploads/2020/08/JAPL8951.jpg', 'https://www.nps.gov/voya/index.htm', '360 Hwy 11 East', 'International Falls', 'MN', '56649');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (57, 'White Sands National Park', '2019-12-20', 'White Sands in New Mexico has white sand dunes from gypsum sand dunefield.', 'https://www.nps.gov/whsa/planyourvisit/images/WHSA_dunefield.jpg?maxwidth=1300&autorotate=false', 'https://www.nps.gov/whsa/index.htm', 'PO Box 1086', 'Holloman AFB', 'NM', '88330');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (58, 'Wind Cave National Park', '1903-01-09', 'Wind Cave in South Dakota has one of the largest and most complex caves in the world with grasslands and hillsides.', 'https://www.nps.gov/articles/images/wica-main.jpg?maxwidth=650&autorotate=false', 'https://www.nps.gov/wica/index.htm', '26611 US Highway 385', 'Hot Springs', 'SD', '57747');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (59, 'Wrangell-St. Elias National Park and Preserve', '1980-12-02', 'Wrangell-St. Elias in Alaska is the same size as Yellowstone, Yosemite, and Switzerland combined.', 'https://i.ytimg.com/vi/RPudBkBW9Tk/maxresdefault.jpg', 'https://www.nps.gov/wrst/index.htm', 'PO Box 439', 'Copper Center', 'AK', '99573');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (60, 'Yellowstone National Park', '1872-03-01', 'Yellowstone in ID, MT, and WY is the first national park and unique hydrothermal and geologic features.', 'https://th-thumbnailer.cdn-si-edu.com/69ZRm0kyzh-SOlgVSorzwaFVW1M=/fit-in/1600x0/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/ee/44/ee44200b-baed-4f0a-b35a-6f09dca74dc1/58611v1.jpg', 'https://www.nps.gov/yell/index.htm', 'PO Box 168', 'Yellowstone National Park', 'WY', '82190');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (61, 'Yosemite National Park', '1890-10-01', 'Yosemite in California is best known for its waterfalls, but also valleys, meadows, sequoias, and wilderness area.', 'https://i.ytimg.com/vi/oTjiWspRCWQ/maxresdefault.jpg', 'https://www.nps.gov/yose/index.htm', 'N/A', 'N/A', 'NA', '932');
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (62, 'Zion National Park', '1919-11-19', 'Zion in Utah with sandstone cliffs of cream, pink, and red. Canyon, wilderness, and unique pants and animal life.', 'https://hikingproject.com/assets/photos/hike/7006725_medium_1554321342.jpg?cache=1686351780', 'https://www.nps.gov/zion/index.htm', '1 Zion Park Blvd.', 'Springdale', 'UT', '84767');

COMMIT;


-- -----------------------------------------------------
-- Data for table `activity`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (1, 'Hiking', 'Explore scenic trails through the forest and enjoy breathtaking views of the surrounding landscape.', 'https://i.pinimg.com/474x/44/7d/43/447d43fdced9360d907b4d2a52f43c23.jpg', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (2, 'Wildlife Viewing', 'Observe the park\'s diverse wildlife, including birds, mammals, and reptiles.', 'https://ih1.redbubble.net/image.2474414216.7981/fposter,small,wall_texture,product,750x1000.jpg', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (3, 'Camping', 'Set up camp and enjoy a night under the stars.', 'https://em-content.zobj.net/socialmedia/apple/81/camping_1f3d5.png', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (4, 'Picnicking', 'Have a relaxing picnic in designated areas with beautiful views.', 'https://i.pinimg.com/originals/8b/d0/ad/8bd0adf775c3046fad3e1d9d37a49030.jpg', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (5, 'Photography', 'Capture the park\'s natural beauty through your lens.', 'https://www.vhv.rs/dpng/d/425-4254278_camera-emoji-png-old-instagram-icon-png-transparent.png', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (6, 'Fishing', 'Try your luck at fishing in the park\'s rivers or lakes.', 'https://em-content.zobj.net/thumbs/160/apple/81/fishing-pole-and-fish_1f3a3.png', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (7, 'Canoeing/Kayaking', 'Paddle along the park\'s waterways for a unique perspective.', 'https://paddlingmagazine-images.s3.amazonaws.com/2018/08/21195732/e66d06d3d52a14b3de2de1317fcb6a37_XL.jpg', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (8, 'Rock Climbing', 'Challenge yourself on the park\'s rock formations and cliffs.', 'https://techcrunch.com/wp-content/uploads/2017/03/activities-emojipedia-emoji-5.jpg?w=700&crop=1', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (9, 'Guided Tours', 'Join a guided tour to learn more about the park\'s history and ecology.', 'https://image.emojipng.com/520/9711520.jpg', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (10, 'Star Gazing', 'Experience the wonders of the night sky. Away from city lights, national parks offer excellent opportunities for stargazing and astrophotography.', 'https://hotemoji.com/images/dl/t/space-emoji-by-google.png', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (11, 'Ranger Programs', 'Participate in ranger-led programs and activities for both adults and children. Learn about nature, conservation, and park ecosystems.', 'https://thumbs.dreamstime.com/b/happy-drill-sergeant-emoticon-cartoon-face-scout-master-forest-ranger-giving-thumbs-up-icon-237992208.jpg', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (12, 'Scenic Drives', 'Take a scenic drive through the park\'s picturesque roads. Enjoy breathtaking views from the comfort of your vehicle.', 'https://www.shutterstock.com/image-vector/driving-emoticon-on-white-background-260nw-191936597.jpg', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (13, 'Biking', 'Explore the park on two wheels by cycling through designated bike paths or off-road trails. Enjoy the thrill of biking in a natural setting.', 'https://images.emojiterra.com/google/android-12l/512px/1f6b2.png', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (14, 'WildFlower Viewing', 'During the blooming season, witness the park\'s vibrant wildflowers. Discover beautiful displays of colors and learn about native flora.', 'https://wallpapers.com/images/hd/cute-emoji-ps7e785u0edkgveq.jpg', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (15, 'Geocaching', 'Embark on a high-tech treasure hunt using GPS coordinates. Geocaching allows you to explore the park while searching for hidden caches.', 'https://geoswag.com/wp-content/uploads/2020/07/Geocache-Love-Emoji-Front_600w.jpg', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (16, 'Junior Ranger Programs', 'Engage children in the park\'s Junior Ranger Program. Kids can complete activities and earn badges while learning about nature and conservation.', 'https://www.nps.gov/apco/learn/kidsyouth/images/Jr-Ranger-logo-Color_2.jpg', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (17, 'Rafting', 'Experience the thrill of white-water rafting in designated areas of the park. Join guided tours for an adrenaline-pumping adventure.', 'https://image.emojisky.com/783/12337783-middle.png', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (18, 'Paddling', 'Rent a stand-up paddleboard or a pedal boat to explore calm waters within the park. Enjoy a leisurely water activity with friends or family.', 'https://rlv.zcache.com/cool_peekaboo_llama_emoji_ping_pong_paddle-r0d0413d3dd7a4b08a14f4ffa0c7b8d40_zvdz5_367.jpg?rlvnet=1&bg=0xFFFFFF', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (19, 'Wilderness BackPacking', 'Embark on multi-day backpacking trips through the park\'s wilderness. Explore remote areas and camp in pristine natural surroundings.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRA7_MmJu3FvdjRLR9TxlsGiE4NTg_SRYkUfA&usqp=CAU', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (20, 'Photography Workshops', 'Join photography workshops led by professionals. Learn new techniques and capture the park\'s beauty from unique perspectives.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6j4zuLHG1-srtiWLLOV8XKtfkbJ3c7J1jDw&usqp=CAU', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (21, 'Horseback Riding', 'Saddle up and ride through designated trails on horseback. Enjoy a leisurely ride while taking in the natural wonders of the park.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjT_Io4X6sDe1E7ajS5CmWWb8P9cEivzWt1w&usqp=CAU', 1);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (22, 'Interpretive Centers', 'Visit interpretive centers within the park to learn about its history, geology, and wildlife through interactive exhibits and displays.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTI2OsKOvZOzahoPtk6ca3aTbEqF9MMUEqrKA&usqp=CAU', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `park_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `park_comment` (`id`, `user_id`, `park_id`, `content`, `reply_to_id`, `created_at`, `enabled`) VALUES (1, 1, 1, 'Don\'t take your eyes off your picnic baskets', NULL, '2023-02-02', 1);
INSERT INTO `park_comment` (`id`, `user_id`, `park_id`, `content`, `reply_to_id`, `created_at`, `enabled`) VALUES (2, 1, 2, 'Don\'t take your eyes off your picnic baskets', NULL, '2023-01-01', 1);
INSERT INTO `park_comment` (`id`, `user_id`, `park_id`, `content`, `reply_to_id`, `created_at`, `enabled`) VALUES (3, 2, 1, 'Enjoy your time folks, me and BooBoo will keep an eye on your things', 1, '2023-01-01', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `attraction`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (1, 'The Travelin Lobster', 'Restaurant - Seafood', 'https://s3-media0.fl.yelpcdn.com/bphoto/3F_8ozC5LeoBmOB_Mmee1Q/o.jpg', 'thetravelinlobster.com', 1, NULL, NULL, 1, 5);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (2, 'Ben & Bills Chocolate Emporium', 'Candy Shop', 'https://s3-media0.fl.yelpcdn.com/bphoto/FxuVL53glHnkQaYy87NWRg/o.jpg', 'benandbills.com', 1, NULL, NULL, 1, 4);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (3, 'Acadia Hotel', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/qMGmewZc9qewW6YEYZtmIw/o.jpg', 'acadiahotel.com', 1, NULL, NULL, 1, 5);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (4, 'Tisa\'s Barefoot Bar', 'Restaurant - Seafood', 'https://s3-media0.fl.yelpcdn.com/bphoto/4e7qO93_aExVIA03rgPIcQ/o.jpg', 'tisasbarefootbar.com', 1, NULL, NULL, 2, 3);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (5, 'Amy\'s Gift Shop', 'Gift Shop', 'https://media.istockphoto.com/id/1136598403/vector/simple-logo-illustration-for-gift-shop-logo-design-emblem-design-concept.jpg?s=612x612&w=0&k=20&c=2pGNrfIFXvg-EUtT8MU6zU852b52QCBA7X-EScer6Cc=', 'https://www.facebook.com/groups/439579647243377/', 1, NULL, NULL, 2, 2);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (6, 'Tradewinds Hotel', 'Lodging', 'https://images.trvl-media.com/lodging/1000000/920000/915800/915770/1d039c97.jpg?impolicy=resizecrop&rw=500&ra=fit', 'tradewinds.as', 1, NULL, NULL, 2, 2);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (7, 'Trailhead Public House & Eatery', 'Restaurant - American', 'https://s3-media0.fl.yelpcdn.com/bphoto/4_IBTDn0n9llODvhDw8jXA/o.jpg', 'moabtrailhead.com', 1, NULL, NULL, 3, 1);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (8, 'Desert Dreams', 'Gift Shop', 'https://s3-media0.fl.yelpcdn.com/bphoto/pel6JEZXPSgoTt5wOxNqmA/o.jpg', 'https://foursquare.com/v/desert-dreams/4c1ac568b9f876b00b447946', 1, NULL, NULL, 3, 3);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (9, 'Red Cliffs Lodge', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/-m3IB_vybogD5xKDOVZ9JQ/o.jpg', 'redcliffslodge.com', 1, NULL, NULL, 3, 1);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (10, 'Badlands Saloon & Grille', 'Restaurant - American', 'https://s3-media0.fl.yelpcdn.com/bphoto/scZc5RjzVlIq1CIP4IpwIA/o.jpg', 'https://www.visitbadlandssaloon.com/', 1, NULL, NULL, 4, 4);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (11, 'Badlands Trading Post', 'Gift Shop', 'https://s3-media0.fl.yelpcdn.com/bphoto/27fc2CpzrOLmkE2XtnNbxw/o.jpg', 'badlandstradingpost.com', 1, NULL, NULL, 4, 4);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (12, 'Frontier Cabins', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/ExOJStOffwqg4hCwzZublA/o.jpg', 'https://www.frontiercabins.com/', 1, NULL, NULL, 4, 5);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (13, 'Bad Rabbit Cafe', 'Restaurant - American', 'https://s3-media0.fl.yelpcdn.com/bphoto/Y10FZ-RFsU2FXjmNq3kaYw/o.jpg', 'terlinguaranch.com', 1, NULL, NULL, 5, 3);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (14, 'Terlingua Trading Company', 'Gift Shop', 'https://s3-media0.fl.yelpcdn.com/bphoto/qlBF8_E2I-d22-IENeYY2Q/o.jpg', 'terlinguatradingco.homestead.com', 1, NULL, NULL, 5, 2);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (15, 'Terlingua Ranch Lodge Resort', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/BY-uy3kss8aoxOpcO8igeA/o.jpg', 'terlinguaranch.com', 1, NULL, NULL, 5, 1);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (16, 'Yardbird Table & Bar', 'Restaurant - Southern', 'https://s3-media0.fl.yelpcdn.com/bphoto/Gv60W555icEtTFfEJpHs0w/o.jpg', 'runchickenrun.com/miami', 1, NULL, NULL, 6, 5);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (17, 'Icy-N-Spicy', 'Candy Shop', 'https://s3-media0.fl.yelpcdn.com/bphoto/h6BO-SI04lpFvT0Ov3AeOQ/o.jpg', 'icynspicy.com', 1, NULL, NULL, 6, 4);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (18, 'Largo Resort', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/mD1DDs8dVgljIpam2hobFA/o.jpg', 'largoresort.com', 1, NULL, NULL, 6, 4);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (19, 'Ted Nelson\'s Steakhouse', 'Restaurant - Steakhouse', 'https://s3-media0.fl.yelpcdn.com/bphoto/RYpOK9eyxUWhNTGtrdkTDA/o.jpg', 'montrosesteakhouse.com', 1, NULL, NULL, 7, 2);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (20, 'Black Canyon Corner', 'Gift Shop', 'https://s3-media0.fl.yelpcdn.com/bphoto/x_LunJijeC50pCahLHUdZQ/o.jpg', 'https://black-canyon-corner-store.business.site/', 1, NULL, NULL, 7, 3);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (21, 'Country Lodge', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/wrC4S9xHUtQvsipwKqlI5Q/o.jpg', 'countrylodgecolorado.com', 1, NULL, NULL, 7, 1);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (22, 'Idk BBQ', 'Restaurant - Barbeque', 'https://s3-media0.fl.yelpcdn.com/bphoto/vfo7ZLFn0CEVBn40oajQ4A/o.jpg', 'idkbarbecue.com', 1, NULL, NULL, 8, 1);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (23, 'Springdale Candy Company', 'Candy Shop', 'https://s3-media0.fl.yelpcdn.com/bphoto/7POkOin45I5_pMC6rJDyLg/o.jpg', 'springdalecandycompany.com', 1, NULL, NULL, 8, 2);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (24, 'Best Western Plus Bryce Canyon Grand Hotel', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/3JlXJli3QmgixhqnTv0OIg/o.jpg', 'bestwestern.com', 1, NULL, NULL, 8, 3);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (25, 'Outlaw\'s Roost', 'Restaurant - Mexican', 'https://s3-media0.fl.yelpcdn.com/bphoto/jKUj-2WfLeDRD04SIuWD3g/o.jpg', 'https://www.instagram.com/outlawsroost/?hl=en', 1, NULL, NULL, 9, 4);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (26, 'Crystal\'s Cake & Cones', 'Dessert Shop', 'https://s3-media0.fl.yelpcdn.com/bphoto/2ZYmq-8j9i8W9JwuXyeoWQ/o.jpg', 'https://crystals-cakes-cones.business.site/', 1, NULL, NULL, 9, 5);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (27, 'Stone Lizard Lodge', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/MWgQAhjAs7GJjFh5cvb1Cg/o.jpg', 'stonelizardlodge.com', 1, NULL, NULL, 9, 5);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (28, 'Rim Rock Restaurant', 'Restaurant - American', 'https://suitehosting.com/therimrock/wp-content/uploads/sites/25/2018/11/therimrock-1400x937.jpg', 'http://therimrock.net/', 1, NULL, NULL, 10, 5);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (29, 'Color Ridge Farm & Creamery', 'Dessert Shop', 'https://s3-media0.fl.yelpcdn.com/bphoto/1muxgNK1Uf_NNtBirwr0uA/o.jpg', 'colorridge.com', 1, NULL, NULL, 10, 4);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (30, 'Capitol Reef Resort', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/qCFKyWfzBvG1HnUJcCThjQ/o.jpg', 'capitolreefresort.com', 1, NULL, NULL, 10, 4);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (31, 'Lucky Bull Grill', 'Restaurant - American', 'https://s3-media0.fl.yelpcdn.com/bphoto/hbqQicaG9NO865VH49gKjA/o.jpg', 'luckybullcarlsbad.com', 1, NULL, NULL, 11, 2);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (32, 'Honey Depot', 'Gift Shop', 'https://scontent-den4-1.xx.fbcdn.net/v/t39.30808-6/292014644_720871052225811_7004163684431601899_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=tBPhUOSt5VMAX-_PWbQ&_nc_ht=scontent-den4-1.xx&oh=00_AfChdMtBCQCcNax6M0gXjLkSRm6D9TSBAt5n6DOv0iS9mA&oe=649AE79C', 'https://www.facebook.com/people/Honey-Depot/100029087696845/', 1, NULL, NULL, 11, 3);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (33, 'Trinity Hotel', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/5_BKysmmHafSgBVeQDLFSg/o.jpg', 'thetrinityhotel.com', 1, NULL, NULL, 11, 1);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (34, 'Teddy\'s By The Sea', 'Restaurant - Seafood', 'https://s3-media0.fl.yelpcdn.com/bphoto/AhfYLqDlV9zG69hhccq6rw/o.jpg', 'teddysbythesea.com', 1, NULL, NULL, 12, 3);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (35, 'Robitailles Fine Candies', 'Candy Shop', 'https://s3-media0.fl.yelpcdn.com/bphoto/7mer-kzdRfiMTf5EKy_c1Q/o.jpg', 'robitaillescandies.com', 1, NULL, NULL, 12, 1);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (36, 'Lavender Inn by the Sea', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/acIxnBV5HvAt22ZgIRcMEQ/o.jpg', 'https://www.sbhotels.com/lavender-inn-by-the-sea?chebs=local-sbhotels-lavender', 1, NULL, NULL, 12, 2);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (37, 'JD\'s Place', 'Restaurant - Diner', 'https://s3-media0.fl.yelpcdn.com/bphoto/9mrTQBgxEOqKXKKZeRoGVg/o.jpg', 'https://www.tripadvisor.com/ShowUserReviews-g54239-d851614-r688280412-J_D_s_Place-Gadsden_South_Carolina.html', 1, NULL, NULL, 13, 5);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (38, 'The South Carolina Shop', 'Gift Shop', 'https://s3-media0.fl.yelpcdn.com/bphoto/VNsfHNg9u6ijcN1QctAxpw/o.jpg', 'scshops.com', 1, NULL, NULL, 13, 4);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (39, 'Hampton Inn & Suites Orangeburg', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/jzNkCWWug1i6ispdIdAKeg/o.jpg', 'hilton.com', 1, NULL, NULL, 13, 5);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (40, 'Beckie\'s Cafe', 'Restaurant - American', 'https://s3-media0.fl.yelpcdn.com/bphoto/vtciaMWYmA4bY1IBXEZTbg/o.jpg', 'https://www.unioncreekoregon.com/dining/beckies-cafe/', 1, NULL, NULL, 14, 4);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (41, 'Violets & Cream', 'Candy Shop', 'https://s3-media0.fl.yelpcdn.com/bphoto/-JMOCDE91TobrVnJoS9wcg/o.jpg', 'violetsandcream.com', 1, NULL, NULL, 14, 4);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (42, 'Crater Lake Resort', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/0MqXkPUnnnKZXB3D3KPPlg/o.jpg', 'craterlakeresort.com', 1, NULL, NULL, 14, 5);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (43, 'Creekside Restaurant & Bar', 'Restaurant - American', 'https://s3-media0.fl.yelpcdn.com/bphoto/jZe_vPXfftpKofTOa2E8cw/o.jpg', 'creeksiderestaurant.com', 1, NULL, NULL, 15, 3);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (44, 'Yellow Creek Trading Company', 'Gift Shop', 'https://s3-media0.fl.yelpcdn.com/bphoto/_xYucv3vfC2XOwg34v7Niw/o.jpg', 'yellowcreektrading.com', 1, NULL, NULL, 15, 2);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (45, 'Inn at Brandywine Falls', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/ZB29yuyZurTzheY7-pJK8g/o.jpg', 'innatbrandywinefalls.com', 1, NULL, NULL, 15, 1);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (46, 'Smokin J\'s Barbeque', 'Restaurant - Barbeque', 'https://s3-media0.fl.yelpcdn.com/bphoto/YTasi-E2PDbBR8jX0V1rPw/o.jpg', 'https://www.facebook.com/Smokinjsbarbecue/', 1, NULL, NULL, 16, 2);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (47, 'Death Valey Nut & Candy', 'Candy Shop', 'https://s3-media0.fl.yelpcdn.com/bphoto/Jtf2B5nyk-62jrBD3knN-w/o.jpg', 'https://www.facebook.com/DeathValleyCandy/', 1, NULL, NULL, 16, 3);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (48, 'Furnace Creek Inn & Ranch Resort', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/f-3nLOy-vvAFNIaBFt7vDQ/o.jpg', 'furnacecreekresort.com', 1, NULL, NULL, 16, 1);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (49, 'McKinley Creekside Cafe', 'Restaurant - Cafe', 'https://s3-media0.fl.yelpcdn.com/bphoto/-P8joGzDpnIpRupgzKl7eA/o.jpg', 'https://www.mckinleycabins.com/en-us/creekside-cafe', 1, NULL, NULL, 17, 5);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (50, 'Denali Summit Gifts & Books', 'Gift Shop', 'http://www.denaligiftshop.com/uploads/2/9/9/7/29971299/published/img-9598.jpg?1687196689', 'https://www.denaligiftshop.com/', 1, NULL, NULL, 17, 5);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (51, 'McKinley Creekside Cabins', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/IsPkA457pnfPhxJ5SaAarg/o.jpg', 'https://www.mckinleycabins.com', 1, NULL, NULL, 17, 4);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (52, 'The Flaming Buoy Filet Co.', 'Restaurant - Seafood', 'https://s3-media0.fl.yelpcdn.com/bphoto/e9sxtHdG-WTz7_FocEjPig/o.jpg', 'theflamingbuoy.com', 1, NULL, NULL, 18, 4);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (53, 'Kermit\'s Key West Key Lime Shoppe', 'Dessert Shop', 'https://s3-media0.fl.yelpcdn.com/bphoto/hjdEFQRYrKbH99vgZit03A/o.jpg', 'keylimeshop.com', 1, NULL, NULL, 18, 4);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (54, 'The Banyan Resort', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/c22ZqfwzGkSXWh0gV0bFxQ/o.jpg', 'thebanyanresort.com', 1, NULL, NULL, 18, 5);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (55, 'Blackwater Siren', 'Restaurant - Seafood', 'https://s3-media0.fl.yelpcdn.com/bphoto/_BFWtm09ZGgaW1W6G1XJ5Q/o.jpg', 'https://www.facebook.com/blackwatersirenkeylargo/', 1, NULL, NULL, 19, 2);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (56, 'Florida Keys Gift Company', 'Gift Shop', 'https://s3-media0.fl.yelpcdn.com/bphoto/_ljjLsdDWDzabWrJKqxT5A/o.jpg', 'https://www.keysmermaid.com/', 1, NULL, NULL, 19, 1);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (57, 'Casa Morada', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/7fRW3c6RDatIPd94QddzYw/o.jpg', 'casamorada.com', 1, NULL, NULL, 19, 3);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (58, 'Oolah Pass Backpack', 'Backpacking', 'https://uploads.alaska.org/suppliers/parks-trails/O/oolah-pass-backpack/_450x300_crop_center-center_65_none/oolah-pass-backpack-haley-johnston-IMG_0222.jpg', 'https://www.alaska.org/detail/oolah-pass-packback', 1, NULL, NULL, 20, 1);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (59, 'Iniakuk Lake Widerness Lodge', 'Lodge', 'https://uploads.alaska.org/suppliers/lodging/I/Iniaukuk-Wilderness-Lodge-Winter-Aurora-Dogsled/_450x300_crop_center-center_65_none/iniakuk-aurora-1-alaska-untitled.jpg', 'https://www.alaska.org/detail/iniakuk-lake-wilderness-lodge-aurora-and-dogsled-expeditions', 1, NULL, NULL, 20, 3);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (60, 'Golden Eagle Outfitters', 'Flightseeing', 'https://uploads.alaska.org/suppliers/activities/G/golden-eagle-outfitters/_450x300_crop_center-center_65_none/golden-eagle-outfitters-flightseeing-air-taxi-IMG_59372019.jpg', 'https://www.alaska.org/detail/golden-eagle-outfitters-flightseeing-air-taxi', 1, NULL, NULL, 20, 2);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (61, 'Backslope Brewing', 'Restaurant - American', 'https://s3-media0.fl.yelpcdn.com/bphoto/a7ua5ddyGHJxiOTBnxLkuA/o.jpg', 'backslopebrewing.com', 1, NULL, NULL, 21, 4);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (62, 'Welch\'s Chocolate Shop', 'Candy Shop', 'https://s3-media0.fl.yelpcdn.com/bphoto/TLQC0x8MZglZ2bLymMfjcg/o.jpg', 'https://welchschocolateshop.weebly.com/', 1, NULL, NULL, 21, 5);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (63, 'The Lodge at Whitefish Lake', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/x2_u8pHR6y4iS6mJZZzuxg/o.jpg', 'lodgeatwhitefishlake.com', 1, NULL, NULL, 21, 4);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (64, 'The Fisherman\'s Daughter', 'Restaurant - Seafood', 'https://s3-media0.fl.yelpcdn.com/bphoto/pb45cf_x1jbsK82XXk9-uA/o.jpg', 'https://www.facebook.com/thefishermansdaughterak/', 1, NULL, NULL, 22, 2);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (65, 'Alaskan Native Eagle Gift Shop', 'Gift Shop', 'https://www.gustavusak.com/wp-content/uploads/2022/05/AD9C4800-3691-4DFC-B5B0-E180590F10B1.jpg', 'https://www.gustavusak.com/shopping/alaskan-native-eagle-gift-shop', 1, NULL, NULL, 22, 1);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (66, 'Glacier Bay Lodge', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/ZNTd26C_vw4-clShLcuL8w/o.jpg', 'visitglacierbay.com', 1, NULL, NULL, 22, 3);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (67, 'Big E Steakhouse & Saloon', 'Restaurant - Steakhouse', 'https://s3-media0.fl.yelpcdn.com/bphoto/M-Ufp2jEh5BCOjZynatS7w/o.jpg', 'bigesteakhouse.com', 1, NULL, NULL, 23, 5);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (68, 'Grand Canyon Chocolate Factory', 'Candy Shop', 'https://s3-media0.fl.yelpcdn.com/bphoto/87GzmOBk98QIwJLzeQuH4g/o.jpg', 'https://www.facebook.com/GrandCanyonChocolateFactory/', 1, NULL, NULL, 23, 5);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (69, 'Yavapai Lodge', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/e4BT1OKSQAWOQtov-SuV8A/o.jpg', 'visitgrandcanyon.com', 1, NULL, NULL, 23, 4);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (70, 'Sugar Salt & Malt Restaurant', 'Restaurant - Cafe', 'https://s3-media0.fl.yelpcdn.com/bphoto/SGRmJaBccWCf7gMhneOpVw/o.jpg', 'saltandsucre.com', 1, NULL, NULL, 24, 3);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (71, 'Lehman Caves Gift & Cafe', 'Gift Shop', 'https://media.istockphoto.com/id/1136598403/vector/simple-logo-illustration-for-gift-shop-logo-design-emblem-design-concept.jpg?s=612x612&w=0&k=20&c=2pGNrfIFXvg-EUtT8MU6zU852b52QCBA7X-EScer6Cc=', 'greatbasinpark.com/', 1, NULL, NULL, 24, 2);
INSERT INTO `attraction` (`id`, `name`, `description`, `image_url`, `website_url`, `enabled`, `created_at`, `updated_at`, `park_id`, `user_id`) VALUES (72, 'Prospector Hotel & Casino', 'Lodging', 'https://s3-media0.fl.yelpcdn.com/bphoto/reVRlZ9M3MAvftr2D_fwIQ/o.jpg', 'https://www.prospectorhotel.us/', 1, NULL, NULL, 24, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `park_has_activity`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (1, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (2, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (3, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (4, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (5, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (6, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (7, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (8, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (9, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (10, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (11, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (12, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (13, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (14, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (15, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (16, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (17, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (18, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (19, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (20, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (21, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (22, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (23, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (24, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (25, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (26, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (27, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (28, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (29, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (30, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (31, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (32, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (33, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (34, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (35, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (36, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (37, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (38, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (39, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (40, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (41, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (42, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (43, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (44, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (45, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (46, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (47, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (48, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (49, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (50, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (51, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (52, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (53, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (54, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (55, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (56, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (57, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (58, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (59, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (60, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (61, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (62, 1);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (1, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (2, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (3, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (4, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (5, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (6, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (7, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (8, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (9, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (10, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (11, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (12, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (13, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (14, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (15, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (16, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (17, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (18, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (19, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (20, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (21, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (22, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (23, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (24, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (25, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (26, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (27, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (28, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (29, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (30, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (31, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (32, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (33, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (34, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (35, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (36, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (37, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (38, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (39, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (40, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (41, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (42, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (43, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (44, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (45, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (46, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (47, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (48, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (49, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (50, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (51, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (52, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (53, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (54, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (55, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (56, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (57, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (58, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (59, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (60, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (61, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (62, 2);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (1, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (2, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (3, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (4, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (5, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (6, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (7, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (8, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (9, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (10, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (11, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (12, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (13, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (14, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (15, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (16, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (17, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (18, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (19, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (20, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (21, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (22, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (23, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (24, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (25, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (26, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (27, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (28, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (29, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (30, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (31, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (32, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (33, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (34, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (35, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (36, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (37, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (38, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (39, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (40, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (41, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (42, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (43, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (44, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (45, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (46, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (47, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (48, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (49, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (50, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (51, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (52, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (53, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (54, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (55, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (56, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (57, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (58, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (59, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (60, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (61, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (62, 5);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (1, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (2, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (3, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (4, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (5, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (6, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (7, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (8, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (9, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (10, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (11, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (12, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (13, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (14, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (15, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (16, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (17, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (18, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (19, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (20, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (21, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (22, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (23, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (24, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (25, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (26, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (27, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (28, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (29, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (30, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (31, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (32, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (33, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (34, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (35, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (36, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (37, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (38, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (39, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (40, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (41, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (42, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (43, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (44, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (45, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (46, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (47, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (48, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (49, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (50, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (51, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (52, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (53, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (54, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (55, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (56, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (57, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (58, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (59, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (60, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (61, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (62, 10);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (1, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (2, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (3, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (4, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (5, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (6, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (7, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (8, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (9, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (10, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (11, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (12, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (13, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (14, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (15, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (16, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (17, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (18, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (19, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (20, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (21, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (22, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (23, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (24, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (25, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (26, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (27, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (28, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (29, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (30, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (31, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (32, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (33, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (34, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (35, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (36, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (37, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (38, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (39, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (40, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (41, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (42, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (43, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (44, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (45, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (46, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (47, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (48, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (49, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (50, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (51, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (52, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (53, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (54, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (55, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (56, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (57, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (58, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (59, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (60, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (61, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (62, 12);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (1, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (2, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (3, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (4, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (5, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (6, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (7, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (8, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (9, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (10, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (11, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (12, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (13, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (14, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (15, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (16, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (17, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (18, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (19, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (20, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (21, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (22, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (23, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (24, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (25, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (26, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (27, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (28, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (29, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (30, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (31, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (32, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (33, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (34, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (35, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (36, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (37, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (38, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (39, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (40, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (41, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (42, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (43, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (44, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (45, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (46, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (47, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (48, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (49, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (50, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (51, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (52, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (53, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (54, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (55, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (56, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (57, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (58, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (59, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (60, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (61, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (62, 15);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (1, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (2, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (3, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (4, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (5, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (6, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (7, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (8, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (9, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (10, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (11, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (12, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (13, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (14, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (15, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (16, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (17, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (18, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (19, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (20, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (21, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (22, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (23, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (24, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (25, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (26, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (27, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (28, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (29, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (30, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (31, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (32, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (33, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (34, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (35, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (36, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (37, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (38, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (39, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (40, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (41, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (42, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (43, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (44, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (45, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (46, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (47, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (48, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (49, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (50, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (51, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (52, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (53, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (54, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (55, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (56, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (57, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (58, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (59, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (60, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (61, 16);
INSERT INTO `park_has_activity` (`park_id`, `activity_id`) VALUES (62, 16);

COMMIT;


-- -----------------------------------------------------
-- Data for table `park_photo`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (1, 1, 1, 'https://www.visitmaine.net/wp-content/uploads/2023/03/Thunder-Hole-Acadia-National-Park-_holmesphotography_.jpg', '2001-03-05');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (2, 1, 3, 'https://good-nature-blog-uploads.s3.amazonaws.com/uploads/2021/07/shutterstock_737942380-resized-1.jpg', '2001-07-12');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (3, 1, 2, 'https://media.tacdn.com/media/attractions-splice-spp-674x446/0b/2d/10/b8.jpg', '2001-10-12');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (5, 2, 4, 'https://www.cakex.org/sites/default/files/Author%20National%20Park%20of%20American%20Samoa_Heniochus_chrysostomus_en_Samoa_wikimedia.jpg', '2005-05-24');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (6, 2, 5, 'https://images.squarespace-cdn.com/content/v1/564d14dfe4b0290681184a82/1478634389379-22M90K3LCX4MAL3C3G6F/image-asset.jpeg', '2005-06-13');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (7, 3, 2, 'https://assets.simpleviewinc.com/simpleview/image/upload/c_fill,h_501,q_75,w_741/v1/clients/utahddm/a10fb35941_eb03db05-e645-4211-8da5-fc9a84351d12.jpg', '2005-08-01');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (8, 3, 4, 'https://images.techyscouts.media/a1a7eaE-cHACrYX0/w:auto/h:auto/q:90/https://www.wildwestvoyages.com/wp-content/uploads/2022/02/AdobeStock_219711874.jpeg', '2006-12-03');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (9, 3, 1, 'https://www.expedia.com/stories/wp-content/uploads/2021/09/landscape-arch-national-park-utah-HERO-1.jpg', '2009-01-03');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (10, 4, 3, 'https://www.doi.gov/sites/doi.gov/files/uploads/badlands-np-andreas-eckert-ste-small_1.jpg', '2009-07-15');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (11, 4, 2, 'https://cdn.aarp.net/content/dam/aarp/travel/Domestic/2020/07/1140-badlands-sunset.jpg', '2010-09-30');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (12, 4, 5, 'https://national-park.com/wp-content/uploads/2016/04/Welcome-to-Badlands-National-Park.jpg', '2011-04-29');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (13, 5, 3, 'https://cdn.aarp.net/content/dam/aarp/travel/destinations/2020/11/1140-big-bend-national-park-hero.jpg', '2012-12-08');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (14, 5, 4, 'https://texaslodging.com/wp-content/uploads/2019/09/Jeremy-T.-Walls.jpg', '2013-11-29');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (15, 5, 1, 'https://texaslodging.com/wp-content/uploads/2019/09/Jeremy-T.-Walls.jpg', '2014-04-04');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (16, 6, 4, 'https://www.nps.gov/bisc/planyourvisit/images/BISC-UW-250711-2_1.jpg?maxwidth=650&autorotate=false', '2018-03-07');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (17, 6, 1, 'https://national-park.com/wp-content/uploads/2016/04/Welcome-to-Biscayne-National-Park.jpg', '2018-07-17');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (18, 6, 3, 'https://cdn2.atlantamagazine.com/wp-content/uploads/sites/4/2016/05/web-IMG_4758b.jpg', '2018-09-08');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (19, 7, 5, 'https://www.enterprise.com/content/dam/ent-brand/inspiration/black-canyon-of-the-gunnison/BLACKCANYON-00041.jpg', '2019-02-27');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (20, 7, 2, 'https://cdn.recreation.gov/public/2018/09/22/19/53/2592_3d8f5b94-9503-4129-88f0-79503ce9ec85_700.jpg', '2019-04-04');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (21, 7, 3, 'https://www.americansouthwest.net/colorado/photographs1118/island-peaks-view.jpg', '2020-05-29');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (22, 8, 5, 'https://www.brycecanyoncountry.com/wp-content/uploads/2022/02/bryce_image-1.jpg', '2021-01-21');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (23, 8, 1, 'https://cdn.allbryce.com/images/content/10371_13540_Natural_Bridge_Bryce_Canyon_National_Park_lg.jpg', '2022-03-22');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (24, 8, 2, 'https://localadventurer.com/wp-content/uploads/2015/06/inspiration-point-bryce-canyon.jpg', '2022-10-13');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (25, 9, 4, 'https://assets.simpleviewinc.com/simpleview/image/upload/c_fill,h_501,q_75,w_741/v1/clients/utahddm/d73a7e3645_224fe2f5-42ad-4e93-805a-53de4cbf8177.jpg', '2022-11-13');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (26, 9, 1, 'https://www.usatoday.com/gcdn/-mm-/f88e274f32b02d150d766347a9ca85b076b08a42/c=0-48-1200-726/local/-/media/2017/03/10/USATODAY/USATODAY/636247487133589675-Canyonlands-from-Green-River-Overlook-Tom-Till.jpg?width=1200&height=600&fit=crop&format=pjpg&auto=webp', '2001-01-10');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (27, 9, 2, 'https://media.tacdn.com/media/attractions-splice-spp-674x446/0b/2d/10/9f.jpg', '2003-02-27');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (28, 10, 4, 'https://assets.simpleviewinc.com/simpleview/image/fetch/c_fill,g_auto,h_797,q_75,w_775/https://assets.simpleviewinc.com/simpleview/image/upload/crm/utahddm/ExploreTheReefSponsor-ca12510808_1803ACA3-5056-A36A-092DBF718FD209B1-1803ab9b5056a36_1803ad09-5056-a36a-0998dc2fd9f23529.jpg', '2004-08-07');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (29, 10, 3, 'https://swnationalparks.com/wp-content/uploads/2021/07/Capitol-Reef.jpg', '2004-12-23');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (30, 10, 5, 'https://www.darksky.org/wp-content/uploads/2015/04/capitol-reef-featured-700px-460px-700x460.png', '2005-03-28');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (31, 11, 5, 'https://www.travelandleisure.com/thmb/cDt8F8xU1A8dIU_9AhkIeZjSpkM=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/carlsbad-caverns-entrance-CCNP1219-03c9387c80004941873ee38dc54a11f9.jpg', '2005-12-25');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (32, 11, 2, 'https://historyfangirl.com/wp-content/uploads/2020/06/shutterstock_132426206.jpg', '2006-10-25');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (33, 11, 3, 'https://www.nps.gov/articles/images/cave-main.jpg?maxwidth=650&autorotate=false', '2006-11-28');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (34, 12, 1, 'https://www.sbadventureco.com/wp-content/uploads/2019/06/potater.jpg', '2007-05-11');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (35, 12, 4, 'https://www.nps.gov/chis/learn/management/images/960-0M9B2139_1.jpg?maxwidth=650&autorotate=false', '2008-02-23');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (36, 12, 2, 'https://cdn2.orangecoast.com/wp-content/uploads/sites/7/2014/05/ChannelIslands.jpg', '2008-03-05');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (37, 13, 3, 'https://cdn2.atlantamagazine.com/wp-content/uploads/sites/4/2016/05/web-_MG_2558.jpg', '2011-02-03');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (38, 13, 1, 'https://media.audubon.org/congaree.jpg?width=1200&height=630&auto=webp&quality=90&fit=crop&disable=upscale', '2013-11-22');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (39, 13, 4, 'https://scpictureproject.org/wp-content/uploads/congaree-national-park-bridge.jpg', '2017-07-09');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (40, 14, 5, 'https://www.travelcraterlake.com/media/823248/crater-lake-under-painted-sky-2434.jpg?anchor=center&mode=crop&width=770&height=346&rnd=132895641180000000', '2017-08-12');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (41, 14, 4, 'https://www.travelcraterlake.com/media/823251/crater-lake-wide-angle-view-121187657-2000.jpg?anchor=center&mode=crop&width=500&height=300&rnd=132890732730000000', '2017-11-25');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (42, 14, 3, 'https://cdn.aarp.net/content/dam/aarp/travel/trips/2020/10/1140-crater-lake-in-winter.jpg', '2018-07-06');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (43, 15, 1, 'https://cdn.aarp.net/content/dam/aarp/travel/trips/2021/03/1140-ledges-trail.jpg', '2018-12-29');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (44, 15, 5, 'https://www.freshwatercleveland.com/galleries/News_Items/2017/Dec_2017/Issue_322/cvnp_ledges_overlook_in_fall1-tom_jones.jpg', '2020-02-12');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (45, 15, 2, 'https://media.tacdn.com/media/attractions-splice-spp-674x446/0b/2d/11/03.jpg', '2020-10-22');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (46, 16, 3, 'https://cdn.aarp.net/content/dam/aarp/travel/national-parks/2021/12/1140-death-valley-park-california.jpg', '2020-11-06');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (47, 16, 2, 'https://www.nps.gov/common/uploads/grid_builder/deva/crop1_1/15633521-0173-93B9-07897C5422EC63E5.jpg?width=640&quality=90&mode=crop', '2021-10-29');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (48, 16, 4, 'https://www.explore.com/img/gallery/the-best-time-to-view-the-milky-way-in-death-valley-national-park/intro-1674231847.jpg', '2021-12-15');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (49, 17, 1, 'https://www.alaskaphotographics.com/wp-content/uploads/2023/01/2126709-2-Bull-moose-and-Mt-Denali-reflection.jpg', '2022-07-07');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (50, 17, 5, 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/Every_Road-_Denali_%287945497984%29.jpg/800px-Every_Road-_Denali_%287945497984%29.jpg', '2022-08-10');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (51, 17, 1, 'https://d27k8xmh3cuzik.cloudfront.net/wp-content/uploads/2018/08/shutterstock_712609225-Copy.jpg', '2004-01-11');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (52, 18, 2, 'https://s3.amazonaws.com/uploads.opalcollection.com/app/uploads/2016/11/10151816/A-Day-Trip-to-Dry-Tortugas-National-Park.jpg', '2005-01-02');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (53, 18, 5, 'https://thecabanainn.com/wp-content/uploads/2019/08/shutterstock_697873732-1.jpg', '2005-01-16');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (54, 18, 4, 'https://www.westchasewow.com/wp-content/uploads/2022/09/Dry-Tortugas0922a.jpg', '2006-01-27');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (55, 19, 3, 'https://cdn.aarp.net/content/dam/aarp/travel/destinations/2020/07/1140-alligator-and-crane-at-everglades.jpg', '2007-10-25');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (56, 19, 5, 'https://national-park.com/wp-content/uploads/2016/04/Welcome-to-Everglades-National-Park.jpg', '2008-07-31');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (57, 19, 1, 'https://www.makefloridayourhome.com/hs-fs/hubfs/MFYH/Blog/Sunset-in-Everglades-National-Park-in-Florida-with-silhouettes-of-tree.jpg?width=960&name=Sunset-in-Everglades-National-Park-in-Florida-with-silhouettes-of-tree.jpg', '2009-01-30');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (58, 20, 4, 'https://www.nationalparkstraveler.org/sites/default/files/styles/panopoly_image_original/public/media/gaar-sunset_nps_700.jpg?itok=q9biMXEB', '2009-07-03');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (59, 20, 3, 'https://i0.wp.com/morethanjustparks.com/wp-content/uploads/2022/12/Shutterstock_240459520.jpg?resize=1100%2C733&ssl=1', '2010-02-18');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (60, 20, 2, 'https://www.nps.gov/common/uploads/grid_builder/gaar/crop16_9/5C1C7A8F-DB23-D362-27CA2F0D28DA7786.jpg?width=640&quality=90&mode=crop', '2010-03-06');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (61, 21, 2, 'https://www.doi.gov/sites/doi.gov/files/styles/social_media_1200x627/public/blog-post/thumbnail-images/glaciernpshanlin.jpg?itok=BlwMSQH5', '2010-05-19');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (62, 21, 3, 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Mountain_Goat_at_Hidden_Lake.jpg/640px-Mountain_Goat_at_Hidden_Lake.jpg', '2011-06-06');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (63, 21, 5, 'https://images.squarespace-cdn.com/content/v1/5abfa5ddda02bc3fe3a5ee71/1629589955370-BO9TM5ES0B84HYWQE87L/glacier-74.jpg?format=1000w', '2012-03-08');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (64, 22, 1, 'https://www.nps.gov/glba/learn/photosmultimedia/images/BlueIce_neilson_2011-30-resizedweb_1.jpg?maxwidth=650&autorotate=false', '2013-08-01');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (65, 22, 4, 'https://downtownjuneauhotel.com/wp-content/uploads/2022/05/shutterstock_2033445503.jpg', '2014-05-04');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (66, 22, 4, 'https://images.fineartamerica.com/images/artworkimages/mediumlarge/1/sunrise-at-lamplugh-glacier-in-glacier-bay-national-park-kevin-adams.jpg', '2014-09-21');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (67, 23, 1, 'https://www.themanual.com/wp-content/uploads/sites/9/2019/06/grand-canyon-national-park-night-time-getty-images.jpg?fit=800%2C800&p=1', '2015-04-21');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (68, 23, 3, 'https://nationalparks-15bc7.kxcdn.com/images/parks/grand-canyon/Grand%20Canyon%20Havasu%20Falls%20landscape.jpg', '2016-09-30');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (69, 23, 2, 'https://www.grandcanyonplaza.com/resourcefiles/attractionsmallimages/grand-canyon-national-park-at-arizona-th.jpg?version=5202023001121', '2018-02-19');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (70, 24, 5, 'https://www.reviewjournal.com/wp-content/uploads/2016/05/web1_dark-park_undated_courtesy_002_4.jpg?w=640', '2019-03-01');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (71, 24, 1, 'https://blog-assets.thedyrt.com/uploads/2019/04/shutterstock_544525882-1.jpg', '2019-03-03');
INSERT INTO `park_photo` (`id`, `park_id`, `user_id`, `image_url`, `image_date`) VALUES (72, 24, 4, 'https://images.theoutbound.com/2018/04/27/21/36c6a6ab76158426a954f66af91a837b?w=300&h=220&fit=crop&q=60&s=7c3070cf5597e7bde96e89f10dac369d&dpr=2', '2019-05-31');

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
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (51, 'AS', 'American Samoa');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (52, 'VI', 'Virgin Islands');

COMMIT;


-- -----------------------------------------------------
-- Data for table `park_has_state`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (1, 19);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (2, 51);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (3, 44);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (4, 43);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (5, 42);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (6, 9);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (7, 6);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (8, 44);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (9, 44);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (10, 44);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (11, 31);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (12, 5);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (13, 40);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (14, 37);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (15, 35);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (16, 5);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (16, 28);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (17, 2);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (18, 9);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (19, 9);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (20, 2);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (21, 26);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (22, 2);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (23, 3);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (24, 28);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (25, 50);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (26, 6);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (27, 33);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (27, 41);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (28, 42);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (29, 11);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (30, 11);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (31, 4);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (32, 14);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (33, 22);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (34, 5);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (35, 2);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (36, 2);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (37, 5);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (38, 2);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (39, 2);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (40, 5);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (41, 17);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (42, 6);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (43, 47);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (44, 48);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (45, 47);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (46, 47);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (47, 3);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (48, 5);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (49, 5);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (50, 6);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (51, 3);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (52, 5);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (53, 46);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (54, 34);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (55, 52);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (56, 23);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (57, 31);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (58, 43);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (59, 2);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (60, 12);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (60, 26);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (60, 50);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (61, 5);
INSERT INTO `park_has_state` (`park_id`, `state_id`) VALUES (62, 44);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_favorites`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (1, 1);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (2, 2);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (3, 3);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (4, 4);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (5, 5);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (1, 6);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (2, 7);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (3, 8);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (4, 9);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (5, 10);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (1, 11);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (2, 12);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (3, 13);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (4, 14);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (5, 15);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (1, 16);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (2, 17);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (3, 18);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (4, 19);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (5, 20);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (1, 21);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (2, 22);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (3, 23);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (4, 24);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (4, 1);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (5, 2);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (1, 3);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (2, 4);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (3, 5);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (4, 6);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (5, 7);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (1, 8);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (2, 9);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (3, 10);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (4, 11);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (5, 12);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (1, 13);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (2, 14);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (3, 15);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (4, 16);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (5, 17);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (1, 18);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (2, 19);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (3, 20);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (4, 21);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (5, 22);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (1, 23);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (2, 24);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (2, 1);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (3, 2);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (4, 3);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (5, 4);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (1, 5);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (2, 6);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (3, 7);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (4, 8);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (5, 9);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (1, 10);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (2, 11);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (3, 12);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (4, 13);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (5, 14);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (1, 15);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (2, 16);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (3, 17);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (4, 18);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (5, 19);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (1, 20);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (2, 21);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (3, 22);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (4, 23);
INSERT INTO `user_favorites` (`user_id`, `park_id`) VALUES (5, 24);

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
INSERT INTO `attraction_comment` (`id`, `user_id`, `content`, `reply_to_id`, `created_at`, `attraction_id`, `enabled`) VALUES (1, 1, 'This place is great', NULL, NULL, 1, 1);
INSERT INTO `attraction_comment` (`id`, `user_id`, `content`, `reply_to_id`, `created_at`, `attraction_id`, `enabled`) VALUES (2, 2, 'Very Rude to Bears just looking for a meal.', NULL, NULL, 1, 1);
INSERT INTO `attraction_comment` (`id`, `user_id`, `content`, `reply_to_id`, `created_at`, `attraction_id`, `enabled`) VALUES (3, 1, 'This place is great', NULL, NULL, 1, 1);
INSERT INTO `attraction_comment` (`id`, `user_id`, `content`, `reply_to_id`, `created_at`, `attraction_id`, `enabled`) VALUES (4, 3, 'I can\'t believe they sprayed you with that Yogi', 2, NULL, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `attraction_rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 2, 'testdata', '2013-12-01', 1);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 2, 'im out of ideas on what too put....', '2017-05-03', 3);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 1, 'still got nothin.', '2021-12-12', 4);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2000-03-06', 1);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2000-06-19', 2);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2001-10-23', 4);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2003-04-03', 5);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 3, 'Awesome!', '2003-07-29', 7);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2003-09-30', 8);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 3, 'Awesome!', '2004-05-17', 9);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2004-08-01', 10);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2004-08-03', 11);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2004-08-06', 12);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2006-03-23', 13);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2006-03-26', 14);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 3, 'Awesome!', '2006-06-22', 15);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2006-11-26', 16);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2007-01-12', 17);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2007-01-16', 18);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2007-01-19', 19);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2007-01-21', 20);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 3, 'Awesome!', '2007-02-11', 21);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 3, 'Awesome!', '2007-06-06', 22);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2007-06-29', 23);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2007-08-04', 24);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2007-09-06', 25);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2000-01-26', 26);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2000-04-16', 28);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2000-06-28', 29);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2000-08-21', 30);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2000-09-12', 31);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2000-11-25', 32);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 3, 'Awesome!', '2001-02-17', 33);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2001-03-08', 34);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2002-10-08', 36);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2002-12-17', 37);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2003-06-19', 38);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2003-08-18', 40);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2004-01-09', 42);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2004-07-25', 43);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2005-02-24', 44);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 3, 'Awesome!', '2005-03-28', 45);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2006-02-23', 46);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2006-04-16', 47);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 3, 'Awesome!', '2006-08-25', 48);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2007-04-04', 49);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2000-02-11', 51);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2000-05-23', 52);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2000-07-09', 54);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2000-12-03', 55);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 3, 'Awesome!', '2001-01-07', 56);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2002-06-23', 57);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2003-03-19', 59);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2003-05-24', 60);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2003-08-03', 61);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2004-01-10', 62);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2004-03-21', 63);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2004-06-22', 64);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 3, 'Awesome!', '2004-09-07', 65);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2005-03-12', 66);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2005-04-18', 67);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2005-09-06', 69);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2005-12-10', 70);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2006-01-26', 71);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 3, 'Awesome!', '2006-06-16', 72);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2008-06-25', 2);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 2, 'I\'d go here again.', '2009-07-17', 3);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 2, 'I\'d go here again.', '2009-08-17', 4);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 1, 'Could\'ve been better', '2009-08-22', 5);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 1, 'Could\'ve been better', '2009-09-14', 6);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2010-07-06', 7);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 3, 'Awesome!', '2010-09-30', 8);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2010-10-05', 9);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 2, 'I\'d go here again.', '2011-06-24', 10);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2012-12-07', 13);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 1, 'Could\'ve been better', '2013-04-13', 14);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 2, 'I\'d go here again.', '2014-05-19', 15);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 1, 'Could\'ve been better', '2014-07-02', 16);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 1, 'Could\'ve been better', '2014-08-10', 17);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2014-10-07', 20);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 2, 'I\'d go here again.', '2014-12-14', 21);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 2, 'I\'d go here again.', '2015-09-19', 24);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 2, 'I\'d go here again.', '2015-12-07', 25);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2015-12-08', 26);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2008-04-24', 27);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2009-11-01', 32);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2010-02-24', 33);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 3, 'Awesome!', '2010-03-30', 34);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2010-04-12', 35);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 1, 'Could\'ve been better', '2011-02-03', 36);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 1, 'Could\'ve been better', '2011-04-22', 37);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 2, 'I\'d go here again.', '2011-06-05', 38);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 2, 'I\'d go here again.', '2011-08-08', 39);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 2, 'I\'d go here again.', '2011-10-04', 40);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 1, 'Could\'ve been better', '2011-11-26', 41);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 2, 'I\'d go here again.', '2012-04-12', 42);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2012-05-11', 43);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2012-12-03', 44);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 1, 'Could\'ve been better', '2013-11-16', 45);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 1, 'Could\'ve been better', '2014-04-22', 46);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2014-05-11', 47);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2014-09-01', 48);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 1, 'Could\'ve been better', '2014-09-26', 49);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 2, 'I\'d go here again.', '2014-12-03', 50);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 2, 'I\'d go here again.', '2015-03-21', 51);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2009-11-01', 54);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2010-08-30', 55);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2010-12-12', 56);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 2, 'I\'d go here again.', '2010-12-25', 57);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2011-02-21', 58);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 3, 'Awesome!', '2012-02-27', 59);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 2, 'I\'d go here again.', '2012-04-19', 60);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2012-08-16', 61);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 1, 'Could\'ve been better', '2012-08-18', 62);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 2, 'I\'d go here again.', '2012-10-24', 63);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 1, 'Could\'ve been better', '2013-01-13', 64);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 1, 'Could\'ve been better', '2013-05-26', 65);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 2, 'I\'d go here again.', '2013-07-26', 66);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 1, 'Could\'ve been better', '2013-08-24', 67);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 2, 'I\'d go here again.', '2013-10-12', 68);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2014-01-06', 70);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 2, 'I\'d go here again.', '2014-03-20', 71);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 2, 'I\'d go here again.', '2014-05-20', 72);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 2, 'I\'d go here again.', '2016-11-07', 3);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 2, 'I\'d go here again.', '2016-12-09', 4);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2017-01-29', 5);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2017-05-05', 6);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2017-11-30', 8);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 2, 'I\'d go here again.', '2018-06-11', 10);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 2, 'I\'d go here again.', '2018-08-07', 11);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 1, 'Could\'ve been better', '2018-08-28', 12);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 1, 'Could\'ve been better', '2018-09-07', 13);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2019-05-30', 14);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2020-02-01', 15);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 2, 'I\'d go here again.', '2020-10-10', 16);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 2, 'I\'d go here again.', '2021-02-22', 17);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 1, 'Could\'ve been better', '2021-05-30', 18);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2021-10-27', 19);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 1, 'Could\'ve been better', '2021-12-29', 20);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2022-01-13', 21);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2022-07-20', 22);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 1, 'Could\'ve been better', '2022-08-17', 23);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 3, 'Awesome!', '2022-09-20', 24);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 1, 'Could\'ve been better', '2023-01-21', 25);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 1, 'Could\'ve been better', '2023-02-26', 26);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2023-03-26', 27);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2016-10-03', 29);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 1, 'Could\'ve been better', '2016-10-29', 30);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2017-03-15', 31);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 1, 'Could\'ve been better', '2017-08-07', 32);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 1, 'Could\'ve been better', '2017-08-18', 33);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 1, 'Could\'ve been better', '2018-05-16', 36);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 2, 'I\'d go here again.', '2018-11-26', 37);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 2, 'I\'d go here again.', '2019-03-19', 38);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 1, 'Could\'ve been better', '2019-05-16', 39);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 2, 'I\'d go here again.', '2019-10-07', 41);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 2, 'I\'d go here again.', '2020-03-18', 43);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2020-06-20', 44);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2020-10-06', 45);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 2, 'I\'d go here again.', '2021-09-26', 47);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2022-04-11', 48);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2022-08-06', 49);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 1, 'Could\'ve been better', '2023-02-28', 50);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2023-05-30', 52);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 2, 'I\'d go here again.', '2016-12-02', 53);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2017-02-26', 55);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 3, 'Awesome!', '2017-07-22', 56);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 3, 'Awesome!', '2018-06-26', 57);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 1, 'Could\'ve been better', '2018-07-16', 58);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 1, 'Could\'ve been better', '2018-08-26', 60);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 3, 'Awesome!', '2018-09-15', 61);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 2, 'I\'d go here again.', '2018-10-11', 62);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 2, 'I\'d go here again.', '2019-02-27', 64);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 1, 'Could\'ve been better', '2019-04-06', 65);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 2, 'I\'d go here again.', '2019-05-26', 66);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 3, 'Awesome!', '2019-08-14', 67);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 2, 'I\'d go here again.', '2020-05-11', 68);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 1, 'Could\'ve been better', '2020-10-13', 69);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (5, 2, 'I\'d go here again.', '2020-11-03', 70);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (4, 3, 'Awesome!', '2020-12-14', 71);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (3, 1, 'Could\'ve been better', '2021-04-05', 72);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (2, 2, 'I\'d go here again.', '2021-11-25', 1);
INSERT INTO `attraction_rating` (`user_id`, `rating`, `rating_comment`, `rating_date`, `attraction_id`) VALUES (1, 3, 'Awesome!', '2022-05-05', 2);

COMMIT;

