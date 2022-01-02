'use strict';

const Joi = require('joi');
const createJsonError = require('../../errors/create-json-error');
const throwJsonError = require('../../errors/throw-json-error');

const { findExperienceById, removeExperienceById } = require('../../repositories/experiences-repository');
const schema = Joi.number().integer().positive().required();

async function deleteExperienceById(req, res) {
    try {
        const { idExperiences } = req.params;
        await schema.validateAsync(idExperiences);

        const experience = await findExperienceById(idExperiences);

        if (!experience) {
            throwJsonError(400, 'Experiencia no existe');
        }
        await removeExperienceById(idExperiences);

        res.status(204);
        res.end();
    } catch (error) {
        createJsonError(error, res);   
    }
}   

module.exports = deleteExperienceById;
    