const User = require('../models/User');

// POST /employees
exports.addEmployee = async (req, res) => {
  try {
    const { name, email,password } = req.body;
    const existingUser = await User.findOne({ $or: [{ email }] });
    if (existingUser) {
      return res.status(400).json({ error: 'Username or Email already exists' });
    }

    const newUser = new User({ name, email, password, role: 'employee' ,isVerified :'false'});
    await newUser.save();
    res.status(201).json(newUser);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// GET /employees
exports.getEmployees = async (req, res) => {
  try {
    const employees = await User.find({ role: 'employee' });
    res.json(employees);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

//employees/verify
exports.verifyEmployee = async (req, res) => {
  const { email } = req.body;

  if (!email) {
    return res.status(400).json({ error: 'Email is required' });
  }

  try {
    const user = await User.findOne({ email, role: 'employee' });

    if (!user) {
      return res.status(404).json({ error: 'Employee not found' });
    }

    user.isVerified = true;
    await user.save();

    res.json({
      message: 'Employee verified successfully',
      user: {
        id: user._id,
        name: user.name,
        email: user.email,
        isVerified: user.isVerified
      }
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};