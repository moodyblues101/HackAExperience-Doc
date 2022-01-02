'use strict';

const createJsonError = require('../../errors/create-json-error');
const throwJsonError = require('../../errors/throw-json-error');
const { findExperienceById } = require('../../repositories/experiences-repository');

async function getExperienceById(req, res) {
    try {
        const { idExperiences } = req.params;
        const experience = await findExperienceById(idExperiences);
        if (experience.length === 0) {
            throwJsonError(400, 'Parametro no valido');
        }
        res.status(200);
        res.send(experience);
    } catch (error) {
        createJsonError(error, res);
    }
}

module.exports = getExperienceById;