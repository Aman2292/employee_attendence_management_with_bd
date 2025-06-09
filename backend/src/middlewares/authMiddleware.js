const jwt = require('jsonwebtoken');
const { jwtSecret } = require('../configs/jwtConfig');

// Middleware to authenticate JWT token
const authMiddleware = (req, res, next) => {
  const token = req.header('Authorization')?.replace('Bearer ', '');

  if (!token) {
    return res.status(401).json({ error: 'No token, authorization denied' });
  }

  try {
    const decoded = jwt.verify(token, jwtSecret);
    req.user = decoded;
    next();
  } catch (err) {
    return res.status(401).json({ error: 'Token is not valid' });
  }
};

// Middleware to check if the user is an Admin
const adminOnlyMiddleware = (req, res, next) => {
  if (req.user.role !== 'admin') {
    return res.status(403).json({ error: 'Access denied. Admin only.' });
  }
  next();
};

// Middleware to check if the user is an Employee
const employeeOnlyMiddleware = (req, res, next) => {
  if (req.user.role !== 'Employee') {
    return res.status(403).json({ error: 'Access denied. Employee only.' });
  }
  next();
};

module.exports = {
  authMiddleware,
  adminOnlyMiddleware,
  employeeOnlyMiddleware
};