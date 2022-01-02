INSERT INTO `users` (
    idUsers,
    userName,
    email,
    userRole,
    userPassword,
    verificationCode,
    verifiedAt,
    createdAt) 
VALUES (
    1,
    'Admin',
    'admin@hackaboss.com',
    'administrador',
    '$2a$10$cRlNLuF9ySIA6rW.DpwZmunEdUTzKcoGpdIcXyAstPhkOR.LvDDDC',
    '88af7ec004103d086b596021a91c25d25c6336da5c012c078031b51acd3d2860',
    '2021-04-22 01:11:14',
    '2021-04-22 01:11:14')
;



INSERT INTO `experiences`(
    idExperiences,
    experienceName,
    experienceDescription,
    city,
    price,
    -- idSubcategories,
    totalPlaces,
    availablePlaces,
    experiencePageVisits,
    eventStartDate,
    eventEndDate,
    createdAt) 
VALUES (1, 'exp1', 'descripicion1', 'Madrid', 25, 10, 10, 0, '2022-01-11', '2022-01-11','2021-12-30 11:52:00'),
    (2, 'exp2', 'descripicion2', 'Santiago', 30, 10, 10, 0, '2022-02-11', '2022-02-11', '2021-12-30 11:50:02'),  
    (3, 'exp3', 'descripicion3', 'A Coruña', 60, 10, 10, 0, ,'2022-03-11', '2022-03-11', '2021-12-30 11:50:04'),
    (4, 'exp4', 'descripicion4', 'Vigo', 15, 10, 10, 0, '2022-04-11', '2022-04-11', '2021-12-30 11:50:06'),
    (5, 'exp5', 'descripicion5', 'Barcelona', 60, 10, 10, 0, '2022-01-11', '2022-01-11', '2021-12-30 11:50:08'),
    (6, 'exp6', 'descripicion6', 'Zaragoza', 75, 10, 10, 0, '2022-02-11', '2022-02-11', '2021-12-30 11:50:10'),
    (7, 'exp7', 'descripicion7', 'Valencia', 35, 10, 10, 0, '2022-03-11', '2022-03-11', '2021-12-30 11:50:12'),
    (8, 'exp8', 'descripicion8', 'Madrid', 55, 10, 10, 0, '2022-04-11', '2022-04-11', '2021-12-30 11:50:14'),
    (9, 'exp9', 'descripicion9', 'Vigo', 50, 10, 10, 0, '2022-01-11', '2022-01-11', '2021-12-30 11:50:16'),
    (10, 'exp10', 'descripicion10', 'Santiago', 30, 10, 10, 0, '2022-02-11', '2022-02-11', '2021-12-30 11:50:18'),
    (11, 'exp11', 'descripicion11', 'A Coruña', 40, 10, 10, 0, '2022-03-11', '2022-03-11', '2021-12-30 11:50:20'),
    (12, 'exp12', 'descripicion12', 'A Coruña', 40, 10, 10, 0, '2022-04-11', '2022-04-11', '2021-12-30 11:50:22')  
;

INSERT INTO 'subCategories' (
	idSubcategories,
    subcategoryName,
    idCategories,
    idExperiences,
	createdAt)
VALUES (1, 'Bienestar', 1, 1, '2021-12-30 11:50:00'),
    (2, 'Gastronomía', 8, 2, '2021-12-30 11:50:02'),
    (3, 'Velocidad', 11, 2, '2021-12-30 11:50:04'),
    (4, 'Aventura', 12, 2, '2021-12-30 11:50:06'),
    (5, 'Sorpresa', 14, 2, '2021-12-30 11:50:08')
;

INSERT INTO 'categories' (
	idCategories,
    categoryName,
    categoryDescription,
	createdAt)
VALUES (1, 'spa', 'descripcion', '2021-12-30 11:49:12'),
    (2, 'yoga', 'descripcion', '2021-12-30 11:49:14'),
    (3, 'mindfulness', 'descripcion', '2021-12-30 11:49:16'),
    (4, 'masajes', 'descripcion', '2021-12-30 11:49:18'),
    (5, 'relax', 'descripcion', '2021-12-30 11:49:20'),
    (6, 'pais', 'descripcion', '2021-12-30 11:49:22'),
    (7, 'vegano', 'descripcion', '2021-12-30 11:49:24'),
    (8, 'a la brasa', 'descripcion', '2021-12-30 11:49:26'),
    (9, 'pescado', 'descripcion', '2021-12-30 11:49:28'),
    (10, 'carne', 'descripcion', '2021-12-30 11:49:30'),
    (11, 'mar', 'descripcion', '2021-12-30 11:49:32'),
    (12, 'tierra', 'descripcion', '2021-12-30 11:49:34'),
    (13, 'para ti ', 'descripcion', '2021-12-30 11:49:36'),
    (14, 'para el', 'descripcion', '2021-12-30 11:49:38'),
    (15, 'para ella', 'descripcion', '2021-12-30 11:49:40'),
    (16, 'para tus amigos', 'descripcion', '2021-12-30 11:49:42'),
    (17, 'para tu familia', 'descripcion', '2021-12-30 11:49:44')
;

-- INSERT INTO 'experienceImages' (
-- 	idExperienceImages,
--     principal,
--     imageName,
--     idExperiences,
--     createdAt,
--     updatedAt)
-- VALUES (),();

-- INSERT INTO `users` () INTO (),();