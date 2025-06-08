const User = require('../models/User');
const bcrypt = require('bcryptjs');

exports.getAllEmployees = async () => {
  return await User.find({ role: 'employee' });
};

exports.addEmployee = async ({ name, email, password }) => {
  const existing = await User.findOne({ email });
  if (existing) {
    throw new Error('Email already exists');
  }

  const hashedPassword = await bcrypt.hash(password, 10);

  const newUser = new User({
    name,
    email,
    password: hashedPassword,
    role: 'employee'
  });

  return await newUser.save();
};