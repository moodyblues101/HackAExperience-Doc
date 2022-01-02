'use strict';

const Joi = require('joi');
const createJsonError = require('../../errors/create-json-error');
const throwJsonError = require('../../errors/throw-json-error');

// const { isAdmin } = require('../../helpers/utils');
const { findExperienceById, updateExperience } = require('../../repositories/experiences-repository');

const schemaId = Joi.number().positive().required();

const schema = Joi.object().keys({
    experienceName: Joi.string().min(3).max(150).required(),
    experienceDescription: Joi.string().min(5).max(400),
    city: Joi.string().min(2).max(50).required(),
    price: Joi.number().integer().positive().required(),
    totalPlaces: Joi.number().integer().min(1).required(),
    eventStartDate: Joi.date().required(),
    eventEndDate: Joi.date().required(),
});

async function updateExperienceById(req, res) {
    try {
        const { idExperiences } = req.params;
        await schemaId.validateAsync(idExperiences);

        // const { userRole } = req.auth;
        // isAdmin(userRole);

        const experience = await findExperienceById(idExperiences);

        if (!experience) {
            throwJsonError(400, 'Experiencia no existe');
        }

        const { body } = req;
        await schema.validateAsync(body);

        await updateExperience(idExperiences, body);

        res.status(204);
        res.end();

    } catch (error) {
        createJsonError(error, res);
    }
}

module.exports = updateExperienceById;