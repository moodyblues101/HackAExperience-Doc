'use strict';

const express = require('express');
// const getExperiencesByCategory = require('../controllers/experiences/get-experiences-by-subcat-controller');
const getExperiences = require('../controllers/experiences/get-experiences-controller');
const getExperienceById = require('../controllers/experiences/get-exp-by-id-controller');
const deleteExperienceById = require('../controllers/experiences/delete-exp-by-id-controller');
const createExperience = require('../controllers/experiences/create-exp-controller');
const uploadExperienceImage = require('../controllers/experiences/upload-exp-image-by-id-controller');
const updateExperienceById = require('../controllers/experiences/update-experience-by-id-controller');
const router = express.Router();

router.route('/').get(getExperiences);
router.route('/:idExperiences').get(getExperienceById);

//TODO: añadir middleware:
router.route('/').post(createExperience);
router.route('/:idExperiences').delete(deleteExperienceById);
router.route('/:idExperiences/images').post(uploadExperienceImage);
router.route('/:idExperiences').put(updateExperienceById);

// router.route('/:idSubcategory').get(getExperiencesByCategory);


module.exports = router;