const express = require('express');
const cors = require('cors');
const pool = require('./db');
const app = express();

app.use(cors());
app.use(express.json());

// 애플 로그인
app.post('/api/apple-signin', async (req, res) => {
  const { userId, userName, email } = req.body;
  try {
    // 이미 가입된 유저인지 확인
    const [existingUser] = await pool.query('SELECT id FROM users WHERE userId = ?', [userId]);
    if (existingUser.length > 0) {
      return res.json({ success: true, user: existingUser[0] });
    }
    // 신규 로그인 유저 가입 처리
    const [result] = await pool.query(
      'INSERT INTO users (userId, userName, email) VALUES (?, ?, ?)',
      [userId, userName, email]
    );
    res.json({ success: true, user: result[0] });
  } catch (err) {
    res.status(500).json({ success: false, error: '가입 실패: DB 오류' });
  }
});

// 닉네임 설정
app.put('/api/nickname', async (req, res) => {
  const { userId, nickname } = req.body;
  try {
    // 유저 존재 여부 확인
    const [user] = await pool.query('SELECT id FROM users WHERE userId = ?', [userId]);
    if (user.length === 0) {
      return res.status(404).json({ success: false, error: '유저가 존재하지 않음' });
    }
    // 닉네임 유효성 검사
    if (!nickname || typeof nickname !== 'string') {
      return res.status(400).json({ success: false, error: '닉네임은 문자열이어야 함' });
    }
    // 닉네임 공백 포함 여부 확인
    if (nickname.trim() !== nickname) {
      return res.status(400).json({ success: false, error: '닉네임에 공백이 포함될 수 없음' });
    }
    // 닉네임 길이 검사
    if (!nickname || nickname.length < 2 || nickname.length > 10) {
      return res.status(400).json({ success: false, error: '닉네임은 2자 이상 10자 이하' });
    }
    // 닉네임 중복 체크
    const [dup] = await pool.query('SELECT id FROM users WHERE nickname = ?', [nickname]);
    if (dup.length > 0) {
      return res.status(409).json({ success: false, error: '중복된 닉네임' });
    }

    // 닉네임 업데이트
    const [result] = await pool.query(
      'UPDATE users SET nickname = ? WHERE userId = ?',
      [nickname, userId]
    );
    // 업데이트 후 유저 정보 반환
    const [rows] = await pool.query(
      'SELECT id, userId, nickname, userName, email FROM users WHERE userId = ?',
      [userId]
    );
    res.json({ success: true, user: rows[0] });
  } catch (err) {
    res.status(500).json({ success: false, error: 'DB 오류' });
  }
});

app.listen(3000, () => {
  console.log('서버가 http://localhost:3000 에서 실행 중');
});