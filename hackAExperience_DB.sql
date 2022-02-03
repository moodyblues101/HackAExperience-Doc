-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema hackAExperience
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hackAExperience
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hackAExperience` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `hackAExperience` ;

-- -----------------------------------------------------
-- Table `hackAExperience`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hackAExperience`.`users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `bio` VARCHAR(250) NULL DEFAULT NULL,
  `profilePic` VARCHAR(200) NULL DEFAULT NULL,
  `role` ENUM('administrador', 'usuario') NULL DEFAULT _utf8mb4'usuario',
  `password` VARCHAR(128) NOT NULL,
  `verificationCode` VARCHAR(64) NULL DEFAULT NULL,
  `verifiedAt` DATETIME NULL DEFAULT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hackAExperience`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hackAExperience`.`categories` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  `description` VARCHAR(400) NULL DEFAULT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hackAExperience`.`experiences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hackAExperience`.`experiences` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  `description` VARCHAR(400) NULL DEFAULT NULL,
  `city` VARCHAR(50) NOT NULL,
  `price` DECIMAL(8,2) NOT NULL,
  `totalPlaces` INT NOT NULL,
  `availablePlaces` INT NULL DEFAULT NULL,
  `visits` INT NULL DEFAULT NULL,
  `eventStartDate` DATE NOT NULL,
  `eventEndDate` DATE NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  `idCategory` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idCategory` (`idCategory` ASC) VISIBLE,
  CONSTRAINT `experiences_ibfk_1`
    FOREIGN KEY (`idCategory`)
    REFERENCES `hackAExperience`.`categories` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hackAExperience`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hackAExperience`.`bookings` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idUser` INT UNSIGNED NOT NULL,
  `idExperience` INT UNSIGNED NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idUser` (`idUser` ASC) VISIBLE,
  INDEX `idExperience` (`idExperience` ASC) VISIBLE,
  CONSTRAINT `bookings_ibfk_1`
    FOREIGN KEY (`idUser`)
    REFERENCES `hackAExperience`.`users` (`id`),
  CONSTRAINT `bookings_ibfk_2`
    FOREIGN KEY (`idExperience`)
    REFERENCES `hackAExperience`.`experiences` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hackAExperience`.`experienceImages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hackAExperience`.`experienceImages` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `principal` TINYINT(1) NULL DEFAULT _utf8mb4'false',
  `name` VARCHAR(200) NOT NULL,
  `idExperience` INT UNSIGNED NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idExperience` (`idExperience` ASC) VISIBLE,
  CONSTRAINT `experienceImages_ibfk_1`
    FOREIGN KEY (`idExperience`)
    REFERENCES `hackAExperience`.`experiences` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hackAExperience`.`reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hackAExperience`.`reviews` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idUser` INT UNSIGNED NOT NULL,
  `idExperience` INT UNSIGNED NOT NULL,
  `comment` VARCHAR(300) NULL DEFAULT NULL,
  `rating` TINYINT NULL DEFAULT NULL,
  `createdAt` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idUser` (`idUser` ASC) VISIBLE,
  INDEX `idExperience` (`idExperience` ASC) VISIBLE,
  CONSTRAINT `reviews_ibfk_1`
    FOREIGN KEY (`idUser`)
    REFERENCES `hackAExperience`.`users` (`id`),
  CONSTRAINT `reviews_ibfk_2`
    FOREIGN KEY (`idExperience`)
    REFERENCES `hackAExperience`.`experiences` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hackAExperience`.`subCategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hackAExperience`.`subCategories` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  `idExperience` INT UNSIGNED NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idExperience` (`idExperience` ASC) VISIBLE,
  CONSTRAINT `subCategories_ibfk_1`
    FOREIGN KEY (`idExperience`)
    REFERENCES `hackAExperience`.`experiences` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
