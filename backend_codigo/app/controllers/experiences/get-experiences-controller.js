'use strict';

const createJsonError = require('../../errors/create-json-error');
const { findAllExperiences } = require('../../repositories/experiences-repository');

async function getExperiences(req, res) {
    try {
        const experiences = await findAllExperiences();
        res.status(200);
        res.send({data: experiences});
    } catch (error) {
        createJsonError(error, res);
    }
}

module.exports = getExperiences;