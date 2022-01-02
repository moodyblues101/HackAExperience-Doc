'use strict';

const throwJsonError = require('../../errors/throw-json-error');
const createJsonError = require('../../errors/create-json-error');
const { findExperiencesBySubcategory } = require("../../repositories/experiences-repository");

async function getExperiencesByCategory(req, res) {
    try {
        const { idSubcategories } = req.params;
        const experiences = await findExperiencesBySubcategory(idSubcategories);
        if (idSubcategories.length === 0) {
            throwJsonError(400, 'Parametro no valido')
        }
        res.status(200);
        res.send(experiences);
    } catch (error) {
        createJsonError(error, res);
    }
}

module.exports = getExperiencesByCategory;