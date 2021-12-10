DROP DATABASE IF EXISTS hackAExperience;
CREATE DATABASE hackAExperience;
USE hackAExperience;

CREATE TABLE users (
    idUsers INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    userName VARCHAR(150) NOT NULL,
    email VARCHAR(100) NOT NULL,
    bio VARCHAR(250)
);

CREATE TABLE userImages (
	idUserImages INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    imageName VARCHAR(200) NOT NULL,
    idUsers INT UNSIGNED,
    FOREIGN KEY (idUsers) 
    REFERENCES users(idUsers)
);

CREATE TABLE roles (
	idRoles INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    userCode INT1 NOT NULL CHECK (userCode >= 1 AND userCode <= 2),
    idUsers INT UNSIGNED,
    FOREIGN KEY (idUsers) 
    REFERENCES users(idUsers)
);

CREATE TABLE experiences (
	idExperiences INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    experienceName VARCHAR(150) NOT NULL,
    city VARCHAR(50) NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    totalPlaces INT NOT NULL,
    availablePlaces INT,
    eventStartDate DATE NOT NULL,
    eventEndDate DATE NOT NULL
);

CREATE TABLE experienceImages (
	idExperienceImages INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    imageName VARCHAR(200) NOT NULL,
    idExperiences INT UNSIGNED,
    FOREIGN KEY (idExperiences) 
    REFERENCES experiences(idExperiences)
);

CREATE TABLE reviews (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    idUsers INT UNSIGNED,
    idExperiences INT UNSIGNED,
    FOREIGN KEY (idUsers)
    REFERENCES users(idUsers),
	FOREIGN KEY (idExperiences)
    REFERENCES experiences(idExperiences),
    reviewComment VARCHAR(300),
    rating DECIMAL(1,1)
);

CREATE TABLE bookings (
	idBookings INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    idUsers INT UNSIGNED,
    FOREIGN KEY (idUsers)
    REFERENCES users(idUsers),
    userStartDate DATE NOT NULL,
    userEndDate DATE NOT NULL
);

CREATE TABLE bookings_has_experiences (
	idBookings INT UNSIGNED,
	idExperiences INT UNSIGNED,
	FOREIGN KEY (idBookings)
    REFERENCES bookings(idBookings),
	FOREIGN KEY (idExperiences)
    REFERENCES experiences(idExperiences)
);