const Attendance = require('../models/Attendance');
const User = require('../models/User');
const { calculateDistance } = require('../services/locationValidationService');

// POST /attendance/check-in
exports.checkIn = async (req, res) => {
  const userId = req.user.id;
  const { latitude, longitude } = req.body;

  try {
    // Optional: Fetch office location from Settings or a separate collection
    const officeLat = 23.0341; // Replace with actual dynamic fetch
    const officeLng = 72.5645;
    const maxRadius = 100; // meters

    const distance = calculateDistance(latitude, longitude, officeLat, officeLng);
    if (distance > maxRadius) {
      return res.status(400).json({ error: 'You are not within office radius' });
    }

    const now = new Date();
    const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());

    let attendance = await Attendance.findOne({
      userId,
      date: { $gte: today, $lt: new Date(today.getTime() + 86400000) }
    });

    if (attendance && attendance.checkInTime) {
      return res.status(400).json({ error: 'Already checked in today' });
    }

    if (!attendance) {
      attendance = new Attendance({
        userId,
        date: now,
        checkInTime: now,
        location: { latitude, longitude },
      });
    } else {
      attendance.checkInTime = now;
    }

    await attendance.save();
    res.json(attendance);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// POST /attendance/check-out
exports.checkOut = async (req, res) => {
  const userId = req.user.id;

  try {
    const now = new Date();
    const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());

    const attendance = await Attendance.findOne({
      userId,
      date: { $gte: today, $lt: new Date(today.getTime() + 86400000) },
      checkInTime: { $exists: true },
      checkOutTime: { $exists: false }
    });

    if (!attendance) {
      return res.status(400).json({ error: 'No active check-in found' });
    }

    attendance.checkOutTime = now;

    const diffMs = attendance.checkOutTime - attendance.checkInTime;
    const workDuration = Math.floor(diffMs / 60000); // in minutes

    attendance.workDuration = workDuration;
    attendance.status = workDuration < 240 ? 'Half-Day' : 'Present';

    await attendance.save();

    res.json(attendance);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// GET /attendance/:userId
exports.getAttendanceLogs = async (req, res) => {
  try {
    const logs = await Attendance.find({ userId: req.params.userId }).sort({ date: -1 });
    res.json(logs);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};