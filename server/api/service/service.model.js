'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var ServiceSchema = new Schema({
  name: String,
  url: String,
  icon: String,
  status: Boolean
});

module.exports = mongoose.model('Service', ServiceSchema);
