"use strict";
const Joi = require("joi");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const createJsonError = require("../../Errors.js/Create-json-error");
const throwJsonError = require("../../Errors.js/Throw-json-error");
const { findUserByEmail } = require("../../Repositories.js/users-repository");
const schema = Joi.object().keys({
  username: Joi.string().email().required(),
  password: Joi.string().min(4).max(20).required(),
});

async function loginUser(req, res) {
  try {
    const { body } = req;
    await schema.validateAsync(body);

    const { username, password } = body;
    const user = await findUserByEmail(username);
    if (!user) {
      throwJsonError(403, "No existe un usuario con ese email y/o password");
    }
    const { id, name, role, password: passwordHash, verifiedAt } = user;
    const isValidPassword = await bcrypt.compare(password, passwordHash);
    if (!isValidPassword) {
      throwJsonError(403, "No existe un usuario con ese email y/o password");
    }

    if (!verifiedAt) {
      throwJsonError(
        401,
        "Verifique su cuenta para poder acceder a nuestros servicios."
      );
    }
    const { JWT_SECRET } = process.env;
    const tokenPayload = { id, name, role, ejemplo: "asdf" };
    const token = jwt.sign(tokenPayload, JWT_SECRET, { expiresIn: "20m" });

    const response = {
      accessToken: token,
      expiresIn: "20m",
    };

    res.status(200);
    res.send(response);
  } catch (error) {
    createJsonError(error, res);
  }
}

module.exports = loginUser;
