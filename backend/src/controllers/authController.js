const bcrypt = require('bcryptjs');
const User = require('../models/User');
const { generateToken } = require('../utils/jwtUtils');

exports.login = async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await User.findOne({ email }).select('+password');
    if (!user || !await bcrypt.compare(password, user.password)) {
      return res.status(400).json({ error: 'Invalid credentials' });
    }

    // Block login if not verified and is an employee
    if (user.role === 'employee' && !user.isVerified) {
      return res.status(403).json({ error: 'Account not verified by admin' });
    }

    if (!user.isActive) {
      return res.status(403).json({ error: 'Account is deactivated' });
    }

    const token = generateToken(user);

    // Update last login time
    user.lastLogin = new Date();
    await user.save();

    res.json({
      token,
      user: {
        id: user._id,
        name: user.name,
        role: user.role,
        isVerified: user.isVerified
      }
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};


// POST /auth/signup
exports.signup = async (req, res) => {
  const {name,  email, password ,role='admin'} = req.body;

  try {
 
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ error: 'Username already exists' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const newUser = new User({
      name,
      email,
      password: hashedPassword,
      role,
      isActive: true
    });

    await newUser.save();

    res.status(201).json({ message: 'User registered successfully' });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};


