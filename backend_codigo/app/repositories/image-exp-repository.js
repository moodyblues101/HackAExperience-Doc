'use strict';

const getPool = require('../infrastructure/database');

async function addImageByIdExperience(idExperiences, fileName, principal = 0) {
    const pool = await getPool();
    const now = new Date();
    const sql = `INSERT INTO experienceImages(
        principal,
        imageName,
        idExperiences
    ) VALUES (?, ?, ?)`;
    const [experiences] = await pool.query(sql, [fileName, principal ? 1 : 0, idExperiences]);

    return true;
}


async function removePrincipalByIdExperience(idExperiences) {
    const pool = await getPool();
    const sql = `UPDATE experienceImages SET principal = 0 WHERE idExperiences = ?`;
    const [result] = await pool.query(sql, idExperiences);

    return (result.affectedRows === 1);
}

module.exports = {
    addImageByIdExperience,
    removePrincipalByIdExperience
}