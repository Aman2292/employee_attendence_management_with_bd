const Attendance = require('../models/Attendance');
const calculateDistance = require('../utils/locationUtils').calculateDistance;

// Office coordinates (you can later fetch from Settings Model)
const officeLat = 23.0341;
const officeLng = 72.5645;
const maxRadius = 100; // meters

exports.checkIn = async (userId, { latitude, longitude }) => {
  const distance = calculateDistance(latitude, longitude, officeLat, officeLng);
  if (distance > maxRadius) {
    throw new Error('You are not within the office radius.');
  }

  const now = new Date();
  const todayStart = new Date(now.getFullYear(), now.getMonth(), now.getDate());
  const todayEnd = new Date(todayStart.getTime() + 86400000);

  let attendance = await Attendance.findOne({
    userId,
    date: { $gte: todayStart, $lt: todayEnd }
  });

  if (attendance && attendance.checkInTime) {
    throw new Error('Already checked in today.');
  }

  if (!attendance) {
    attendance = new Attendance({
      userId,
      date: now,
      checkInTime: now,
      location: { latitude, longitude }
    });
  } else {
    attendance.checkInTime = now;
  }

  await attendance.save();
  return attendance;
};

exports.checkOut = async (userId) => {
  const now = new Date();
  const todayStart = new Date(now.getFullYear(), now.getMonth(), now.getDate());
  const todayEnd = new Date(todayStart.getTime() + 86400000);

  const attendance = await Attendance.findOne({
    userId,
    date: { $gte: todayStart, $lt: todayEnd },
    checkInTime: { $exists: true },
    checkOutTime: { $exists: false }
  });

  if (!attendance) {
    throw new Error('No active check-in found.');
  }

  attendance.checkOutTime = now;
  await attendance.save();

  return attendance;
};

exports.getAttendanceLogs = async (userId) => {
  return await Attendance.find({ userId }).sort({ date: -1 });
};