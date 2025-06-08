const express = require('express');
const router = express.Router();

const employeeController = require('../controllers/employeeController');
const { authMiddleware, adminOnlyMiddleware } = require('../middlewares/authMiddleware');

// Apply middleware to protect routes
router.use(authMiddleware);
router.use(adminOnlyMiddleware);

// Admin-only routes
router.post('/', employeeController.addEmployee);
router.get('/', employeeController.getEmployees);

module.exports = router;