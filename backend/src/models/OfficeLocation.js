const mongoose = require('mongoose');

const officeLocationSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  latitude: {
    type: Number,
    required: true
  },
  longitude: {
    type: Number,
    required: true
  },
  radiusMeters: {
    type: Number,
    required: true,
    default: 100 // Default radius of 100 meters
  }
});

module.exports = mongoose.model('OfficeLocation', officeLocationSchema);