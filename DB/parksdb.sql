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
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `park_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `image_url` VARCHAR(2000) NULL,
  `website_url` VARCHAR(2000) NULL,
  `enabled` TINYINT NULL,
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
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `description`, `created_at`, `updated_at`) VALUES (1, 'admin', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, NULL, NULL, NULL, 'https://static.simpsonswiki.com/images/thumb/e/e5/That%27s_a_paddlin%27.png/250px-That%27s_a_paddlin%27.png', NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `description`, `created_at`, `updated_at`) VALUES (2, 'coon', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, NULL, NULL, NULL, 'https://images.paramount.tech/uri/mgid:arc:imageassetref:shared.southpark.us.en:02416969-40fd-415a-96d2-4218519c613f?quality=0.7&gen=ntrn&legacyStatusCode=true', NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `description`, `created_at`, `updated_at`) VALUES (3, 'user3', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `description`, `created_at`, `updated_at`) VALUES (4, 'user4', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `description`, `created_at`, `updated_at`) VALUES (5, 'user5', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `park`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (1, 'testPark1', '2012-05-01', 'ahhhhhhhhhhhhhhhhh', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (2, 'tp2', '2000-02-10', 'stop beeping at me!', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (3, 'tp3', '1201-01-01', 'mwb is being rude', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `park` (`id`, `name`, `date_established`, `description`, `image_url`, `website_url`, `street`, `city`, `state`, `zip`) VALUES (4, 'tp4', '0001-01-01', 'uggaaa ug ug do', NULL, NULL, NULL, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `activity`
-- -----------------------------------------------------
START TRANSACTION;
USE `parksdb`;
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (1, 'Hiking', 'eww nature', NULL, NULL);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (2, 'Camping', 'testing', NULL, NULL);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (3, 'Kayaking', 'you got something', NULL, NULL);
INSERT INTO `activity` (`id`, `name`, `description`, `image_url`, `enabled`) VALUES (4, 'Canoing', 'asdsdf', NULL, NULL);

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
INSERT INTO `attraction` (`id`, `name`, `description`, `created_at`, `updated_at`, `park_id`, `user_id`, `image_url`, `website_url`, `enabled`) VALUES (1, 'burgerplace', 'ahhhhhhhhhhhhh', NULL, NULL, 1, 1, NULL, NULL, NULL);
INSERT INTO `attraction` (`id`, `name`, `description`, `created_at`, `updated_at`, `park_id`, `user_id`, `image_url`, `website_url`, `enabled`) VALUES (2, 'testing', 'patrick was here', NULL, NULL, 1, 1, NULL, NULL, NULL);
INSERT INTO `attraction` (`id`, `name`, `description`, `created_at`, `updated_at`, `park_id`, `user_id`, `image_url`, `website_url`, `enabled`) VALUES (3, 'the', 'game', NULL, NULL, 1, 1, NULL, NULL, NULL);
INSERT INTO `attraction` (`id`, `name`, `description`, `created_at`, `updated_at`, `park_id`, `user_id`, `image_url`, `website_url`, `enabled`) VALUES (4, 'you', 'lost', NULL, NULL, 1, 1, NULL, NULL, NULL);

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
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (1, 'TX', 'Texas');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (2, 'CO', 'Colorao');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (3, 'FL', 'Florida');
INSERT INTO `state` (`id`, `abbreviation`, `name`) VALUES (4, 'OK', 'Oklahoma');

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
INSERT INTO `park_rating` (`user_id`, `park_id`, `rating`, `rating_comment`, `rating_date`) VALUES (3, 2, 3, NULL, NULL);
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

