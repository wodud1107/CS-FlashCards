require('dotenv').config();
const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: 'DB_HOST',
  user: 'DB_USER',
  password: 'DB_PASSWORD',
  database: 'DB_NAME',
});

module.exports = pool;