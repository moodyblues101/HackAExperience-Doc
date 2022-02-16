"use strict";
const getPool = require("../infrastructure/database");

async function createUser(user) {
  const pool = await getPool();
  const sql = `
    INSERT INTO users(
      name, email, password, verificationCode, role,
      createdAt
    ) VALUES (?, ?, ?, ?, ?, ?)
  `;
  const { name, email, passwordHash, verificationCode } = user;
  const now = new Date();
  const [created] = await pool.query(sql, [
    name,
    email,
    passwordHash,
    verificationCode,
    "reader",
    now,
  ]);

  return created.insertId;
}
async function findUserById(id) {
  const pool = await getPool();
  const sql = "SELECT * FROM users WHERE id = ?";
  const [users] = await pool.query(sql, id);

  return users[0];
}
async function findUserByEmail(email) {
  const pool = await getPool();
  const sql =
    "SELECT id, name, email, role, password, verifiedAt FROM users WHERE email = ?";
  const [user] = await pool.query(sql, email);

  return user[0];
}

async function activateUser(verificationCode) {
  const now = new Date();
  const pool = await getPool();
  const sql = `
    UPDATE users
    SET verifiedAt = ?
    WHERE verificationCode = ?
    AND verifiedAt IS NULL
  `;
  const [result] = await pool.query(sql, [now, verificationCode]);

  return result.affectedRows === 1;
}

async function getUserByVerificationCode(code) {
  const pool = await getPool();
  const sql = `
    SELECT name, email
    FROM users WHERE verificationCode = ?
  `;
  const [user] = await pool.query(sql, code);

  return user[0];
}

async function findAllUsers() {
  const pool = await getPool();
  const sql = "SELECT id, name, email, verifiedAt FROM users";
  const [users] = await pool.query(sql);

  return users;
}

async function udpateUserById(data) {
  const { id, name, email, password } = data;
  const pool = await getPool();
  const sql = `
    UPDATE users
    SET name = ?, email = ?, password = ?
    WHERE id = ?
  `;
  await pool.query(sql, [name, email, password, id]);

  return true;
}

async function addVerificationCode(id, code) {
  const now = new Date();
  const pool = await getPool();
  const sql = `
    UPDATE users SET verificationCode = ?,
    updatedAt = ?,
    verifiedAt = NULL
    WHERE id = ?
  `;
  const [created] = await pool.query(sql, [code, now, id]);

  return created.insertId;
}

async function findUserProfileImage(id) {
  const pool = await getPool();
  const sql = "SELECT image FROM users WHERE id = ?";
  const [users] = await pool.query(sql, id);

  return users[0];
}

async function uploadUserProfileImage(id, image) {
  const pool = await getPool();
  const sql = "UPDATE users SET image = ? WHERE id = ?";
  await pool.query(sql, [image, id]);

  return true;
}

async function removeUserById(id) {
  const pool = await getPool();
  const sql = "DELETE FROM users WHERE id = ?";
  await pool.query(sql, id);

  return true;
}

module.exports = {
  activateUser,
  addVerificationCode,
  createUser,
  findAllUsers,
  findUserByEmail,
  findUserById,
  findUserProfileImage,
  getUserByVerificationCode,
  removeUserById,
  udpateUserById,
  uploadUserProfileImage,
};
