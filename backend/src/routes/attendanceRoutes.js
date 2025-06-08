const express = require('express');
const router = express.Router();

const attendanceController = require('../controllers/attendanceController');
const { authMiddleware, employeeOnlyMiddleware } = require('../middlewares/authMiddleware');

// Protect all attendance routes with auth + role
router.use(authMiddleware);
router.use(employeeOnlyMiddleware);

router.post('/check-in', attendanceController.checkIn);
router.post('/check-out', attendanceController.checkOut);
router.get('/:userId', attendanceController.getAttendanceLogs);

module.exports = router;