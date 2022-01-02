'use strict';

const getPool = require('../infrastructure/database');

async function findAllExperiences() {
  const pool = await getPool();
  const sql = `SELECT * FROM experiences`;
  const [experiences] = await pool.query(sql);

  return experiences;
}

async function findExperienceById(idExperiences) {
  const pool = await getPool();
  const sql = 'SELECT * FROM experiences WHERE idExperiences = ?';
  const [experience] = await pool.query(sql, idExperiences);

  return experience[0];
  
}

async function findExperiencesBySubcategory(idSubcategories) {
  const pool = await getPool();
  const sql = `SELECT * FROM subCategories WHERE idSubcategories = ?`;
  const [experiences] = await pool.query(sql, idSubcategories);

  return experiences[0];
}

async function addExperience(experience) {
  const pool = await getPool();
  const now = new Date();
  const consulta = `INSERT INTO experiences (
    experienceName,
    experienceDescription,
    city,
    price,
    totalPlaces,
    availablePlaces,
    eventStartDate,
    eventEndDate,
    createdAt
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`;

  const { experienceName,
    experienceDescription,
    city,
    price,
    totalPlaces,
    eventStartDate,
    eventEndDate } = experience;

  const [created] = await pool.query(consulta, [
    experienceName,
    experienceDescription,
    city,
    price,
    totalPlaces,
    totalPlaces,
    eventStartDate,
    eventEndDate,
    now,
  ]);

  return created.insertId;
}

async function updateExperience(idExperiences, experience) {
  const { experienceName,
    experienceDescription,
    city,
    price,
    totalPlaces,
    availablePlaces,
    eventStartDate,
    eventEndDate } = experience;
  
  const now = new Date();
  const pool = await getPool();
  const sql = `UPDATE experiences 
    SET experienceName = ?,
    experienceDescription = ?,
    city = ?,
    price = ?,
    totalPlaces = ?,
    availablePlaces = ?,
    eventStartDate = ?,
    eventEndDate = ?,
    updatedAt = ?
    WHERE idExperiences = ?`;
  const [result] = await pool.query(sql, 
    [experienceName,
    experienceDescription,
    city,
    price,
    totalPlaces,
    availablePlaces,
    eventStartDate,
    eventEndDate,
    now,
    idExperiences]); 

  return (result.affectedRows === 1);
}

async function removeExperienceById(idExperiences) {
  const pool = await getPool();
  const sql = 'DELETE FROM experiences WHERE idExperiences = ?';
  await pool.query(sql, idExperiences);

  return true;
}



module.exports = {
    addExperience,
    findAllExperiences,
    findExperienceById,
    findExperiencesBySubcategory,
    removeExperienceById,
    updateExperience,
}