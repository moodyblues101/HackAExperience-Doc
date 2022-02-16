"use strict";
const Joi = require("joi");
const bcrypt = require("bcryptjs");
const randomstring = require("randomstring");

const createJsonError = require("../../errors/create-json-error");
const throwJsonError = require("../../errors/throw-json-error.js");
const {
  createUser,
  findUserByEmail,
} = require("../../repositories/users-repository");
const { sendMailRegister } = require("../../helpers/mail-smtp"); //

const { HTTP_SERVER_DOMAIN } = process.env;

const schema = Joi.object().keys({
  name: Joi.string().min(4).max(120).required(),
  email: Joi.string().email().required(),
  password: Joi.string().min(4).max(20).required(),
  verifyPassword: Joi.ref("password"),
});

async function registerUser(req, res) {
  try {
    const { body } = req;
    await schema.validateAsync(body);
    const { name, email, password } = body;
    const user = await findUserByEmail(email);
    if (user) {
      // const error = new Error('Ya existe un usuario con ese email');
      // error.status = 400; //409 - Conflict
      // throw error;
      // Este codigo de arriba se reemplaza por una funcion
      throwJsonError(409, "Ya existe un usuario con ese email");
    }
    // Crear el Hash el password
    const passwordHash = await bcrypt.hash(password, 12);
    // Crear el verificationCode
    const verificationCode = randomstring.generate(64);
    // Crear Object user con los campos
    const userDB = { name, email, passwordHash, verificationCode };
    // LLamamos a la base de datos - createUser
    const userId = await createUser(userDB);
    // Enviar email de verificacion cuenta
    await sendMailRegister(name, email, verificationCode);

    // Creamos link de activación y lo mostramos por si el email no funciona
    // pero este parámetro no debería formar parte de la repuesta del endpoint
    // pq para activar el usuario debería hacerse siempre desde el email
    const activationLink = `${HTTP_SERVER_DOMAIN}/api/v1/users/activation?code=${verificationCode}`;

    res.status(201);
    // === RESPUESTA INCORRECTA, PUESTA SOLO PARA FACILITAR ACTIVACION USUARIO ===
    // res.send({
    //   id: userId,
    //   activationLink,
    // });
    // ==== RESPUESTA CORRECTA ===
    res.send({
      id: userId,
    });
  } catch (error) {
    createJsonError(error, res);
  }
}

module.exports = registerUser;
