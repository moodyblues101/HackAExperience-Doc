'use strict';

const Joi = require('joi');
const createJsonError = require('../../errors/create-json-error');
const throwJsonError = require('../../errors/throw-json-error');
const uploadImage = require('../../helpers/upload-image');

// const { isAdmin } = require('../../helpers/utils');
const { addImageByIdExperience, removePrincipalByIdExperience } = require('../../repositories/image-exp-repository');

const { HTTP_SERVER, PATH_EXPERIENCES_IMAGE } = process.env; 

const schema = Joi.number().positive().integer().required();
const schemaPrincipal = Joi.boolean();

async function uploadExperienceImage(req, res) {
    try {
        const { idExperiences } = req.params;
        await schema.validateAsync(idExperiences);
        // const { userRole } = req.auth;
        // isAdmin(userRole);
        const { body } = req;
        const { principal } = body;
        await schemaPrincipal.validateAsync(principal);

        const { files } = req;
        if (!files || Object.keys(files).length === 0) {
            throwJsonError(400, 'No se ha seleccionado ningun fichero');
        }

        const { imageExperience } = req;

        console.log('imagen: ', imageExperience);
        if (!imageExperience) {
            throwJsonError(400, 'Fichero subido no valido');
        }
        if (!imageExperience.mimetype.startsWith('image')) {
            throwJsonError(400, 'Formato no valido');
        }

        const processImage = await uploadImage({
            imageData: imageExperience.data,
            destination: `${PATH_EXPERIENCES_IMAGE}/${idExperiences}`,
            widht: 600,
            height: 600,
            codImage: idExperiences,
        });
        if (principal) {
            await removePrincipalByIdExperience(idExperiences);
        }
        await addImageByIdExperience(idExperiences, processImage, principal);

        res.status(201);
        res.send({ image: `${HTTP_SERVER}/${PATH_EXPERIENCES_IMAGE}/${idExperiences}/${processImage}`});

    } catch (error) {
        createJsonError(error, res);
    }
}

module.exports = uploadExperienceImage;