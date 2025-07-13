const express = require('express');
const cors = require('cors');
const userRoutes = require('./routes/user');
const authRoutes = require('./routes/auth');
const flashcardRoutes = require('./routes/flashcard');

const app = express();

app.use(cors());
app.use(express.json());

app.use('/api/user', userRoutes);
app.use('/api/auth', authRoutes);
app.use('/api/flashcard', flashcardRoutes);

app.listen(3000, () => {
  console.log('서버가 http://localhost:3000 에서 실행 중');
});