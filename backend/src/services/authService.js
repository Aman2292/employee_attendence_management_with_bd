const bcrypt = require('bcryptjs');
const User = require('../models/User');
const jwtUtils = require('../utils/jwtUtils');

exports.login = async ({ email, password }) => {
  const user = await User.findOne({ email }).select('+password');

  if (!user || !(await bcrypt.compare(password, user.password))) {
    throw new Error('Invalid credentials');
  }

  console.log('User role:', user.role); // Debugging

  // Update last login
  user.lastLogin = new Date();
  await user.save();

  const token = jwtUtils.generateToken(user);

  return {
    token,
    user: {
      id: user._id,
      role: user.role
    }
  };
};


exports.signup = async ({ name, email, password }) => {
  const existingUser = await User.findOne({ email });
  if (existingUser) {
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