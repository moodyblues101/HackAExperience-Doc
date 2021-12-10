DROP DATABASE IF EXISTS hackAExperience;
CREATE DATABASE hackAExperience;
USE hackAExperience;

CREATE TABLE users (
    idUsers INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    userName VARCHAR(150) NOT NULL,
    email VARCHAR(100) NOT NULL,
    bio VARCHAR(250) NULL DEFAULT NULL,
    profilePic VARCHAR(200) NULL DEFAULT NULL,
    userRole ENUM ('administrador', 'usuario') NULL DEFAULT ('usuario'),
    userPassword VARCHAR(128) NOT NULL,
    verificationCode VARCHAR(64) NULL DEFAULT NULL,
    verifiedAt DATETIME NULL DEFAULT NULL,
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME NULL DEFAULT NULL
);

CREATE TABLE experiences (
	idExperiences INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    experienceName VARCHAR(150) NOT NULL,
    experienceDescription VARCHAR(400),
    city VARCHAR(50) NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    totalPlaces INT NOT NULL,
    availablePlaces INT,
    experiencePageVisits INT,
    eventStartDate DATE NOT NULL,
    eventEndDate DATE NOT NULL,
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME NULL DEFAULT NULL
);

CREATE TABLE categories (
	idCategories INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    categoryName VARCHAR(150) NOT NULL,
    categoryDescription VARCHAR(400),
	createdAt DATETIME NOT NULL,
    updatedAt DATETIME NULL DEFAULT NULL
);

CREATE TABLE subCategories (
	idSubcategories INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    subcategoryName VARCHAR(150) NOT NULL,
    idCategories INT UNSIGNED NOT NULL,
    idExperiences INT UNSIGNED NOT NULL,
    FOREIGN KEY (idCategories) 
    REFERENCES categories(idCategories),
    FOREIGN KEY (idExperiences) 
    REFERENCES experiences(idExperiences),
	createdAt DATETIME NOT NULL,
    updatedAt DATETIME NULL DEFAULT NULL
);

CREATE TABLE experienceImages (
	idExperienceImages INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    principal BOOLEAN NULL DEFAULT ('false'),
    imageName VARCHAR(200) NOT NULL,
    idExperiences INT UNSIGNED NOT NULL,
    FOREIGN KEY (idExperiences) 
    REFERENCES experiences(idExperiences),
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME NULL DEFAULT NULL
);

CREATE TABLE reviews (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    idUsers INT UNSIGNED NOT NULL,
    idExperiences INT UNSIGNED NOT NULL,
    FOREIGN KEY (idUsers)
    REFERENCES users(idUsers),
	FOREIGN KEY (idExperiences)
    REFERENCES experiences(idExperiences),
    reviewComment VARCHAR(300),
    rating TINYINT CHECK(rating > 0 AND rating <= 5),
    createdAt DATETIME NOT NULL
);

CREATE TABLE bookings (
	idBookings INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    idUsers INT UNSIGNED NOT NULL,
    idExperiences INT UNSIGNED NOT NULL,
    FOREIGN KEY (idUsers)
    REFERENCES users(idUsers),
    FOREIGN KEY (idExperiences)
    REFERENCES experiences(idExperiences),
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME NULL DEFAULT NULL,
    userStartDate DATE NOT NULL,
    userEndDate DATE NOT NULL
);