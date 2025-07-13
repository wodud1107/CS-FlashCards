const express = require('express');
const cors = require('cors');
const pool = require('./db');
const app = express();

app.use(cors());
app.use(express.json());

// 회원가입 API
app.post('/api/register', async (req, res) => {
  const { userId, password, nickname } = req.body;
  try {
    const [rows] = await pool.query(
      'INSERT INTO users (userId, password, nickname) VALUES (?, ?, ?)',
      [userId, password, nickname]
    );
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ success: false, error: '이미 등록된 이메일이거나 DB 오류' });
  }
});

// 로그인 API
app.post('/api/login', async (req, res) => {
  const { userId, password } = req.body;
  try {
    const [rows] = await pool.query(
      'SELECT id, userId, nickname FROM users WHERE userId = ? AND password = ?',
      [userId, password]
    );
    if (rows.length > 0) {
      res.json({ success: true, user: rows[0] });
    } else {
      res.status(401).json({ success: false, error: '로그인 실패: 아이디/비밀번호 확인' });
    }
  } catch (err) {
    res.status(500).json({ success: false, error: 'DB 오류' });
  }
});

app.listen(3000, () => {
  console.log('서버가 http://localhost:3000 에서 실행 중');
});