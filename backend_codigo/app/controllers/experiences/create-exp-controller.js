'use strict';

const Joi = require('joi');
const createJsonError = require('../../errors/create-json-error');
// const { isAdmin } = require('../../helpers/utils');
const { addExperience } = require('../../repositories/experiences-repository');

const schema = Joi.object().keys({
    experienceName: Joi.string().min(3).max(150).required(),
    experienceDescription: Joi.string().min(5).max(400),
    city: Joi.string().min(2).max(50).required(),
    price: Joi.number().integer().positive().required(),
    totalPlaces: Joi.number().integer().min(1).required(),
    eventStartDate: Joi.date().required(),
    eventEndDate: Joi.date().required(),
});

async function createExperience(req, res) {
    try {
        // const { role } = req.auth;
        // isAdmin(role);

        const { body } = req;

        await schema.validateAsync(body);
        const idExperiences = await addExperience(body);

        res.status(201);
        res.send({message: `Experiencia ${idExperiences} creada correctamente`});
    } catch (error) {
        createJsonError(error, res);
    }
}

module.exports = createExperience;