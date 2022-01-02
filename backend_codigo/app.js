'use strict';

require('dotenv').config();
const express = require('express');
const cors = require('cors');
// const morgan = require('morgan');
const fs = require('fs');
const path = require('path');
const app = express();
const fileUpload = require('express-fileupload');

const { PORT } = process.env;
const port = PORT | 3000;

// Para subir ficheros
app.use(fileUpload());
// Para mostrar ficheros, imagenes, css... en carpeta public
app.use(express.static('public'));
// Recibir datos como json en el body
app.use(express.json());
// CORS - dar permisos de acceso a otras URLs
app.use(cors());

const experiencesRouter = require('./app/routes/experiences-routes');

app.use('/api/v1/experiences/', experiencesRouter);

app.listen(port, () => console.log(`Running ${port}`));