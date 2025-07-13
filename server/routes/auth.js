const express = require('express');
const router = express.Router();
const pool = require('../db');
const jwt = require('jsonwebtoken');

// 애플 로그인
router.post('/apple-signin', async (req, res) => {
  const { userId, userName, email } = req.body;
  try {
    // 이미 가입된 유저인지 확인
    const [rows] = await pool.query(
      'SELECT id, userId, nickname, userName, email FROM users WHERE userId = ?',
      [userId]
    );
    let user;
    if (rows.length > 0) {
      user = rows[0];
    } else {
      const [result] = await pool.query(
        'INSERT INTO users (userId, userName, email) VALUES (?, ?, ?)',
        [userId, userName, email]
      );
      const [newUser] = await pool.query(
        'SELECT id, userId, nickname, userName, email FROM users WHERE id = ?',
        [result.insertId]
      );
      user = newUser[0];
    }
    const payload = { id: user.id, userId: user.userId, email: user.email }
    const token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '7d' });
    res.json({ success: true, user, token });
  } catch (err) {
    res.status(500).json({ success: false, error: '가입 실패: DB 오류' });
  }
});