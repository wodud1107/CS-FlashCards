const jwt = require('jsonwebtoken');

function authenticateJWT(req, res, next) {
  const authHeader = req.headers.authorization;
  if (!authHeader) {
    return res.status(401).json({ success: false, error: "토큰 없음" });
  }
  const token = authHeader.split(' ')[1];
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded; // payload(userId, email 등) 할당
    next();
  } catch (err) {
    return res.status(401).json({ success: false, error: "토큰 만료/유효하지 않음" });
  }
}