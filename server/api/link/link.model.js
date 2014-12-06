'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var LinkSchema = new Schema({
  name: String,
  link: String,
  icon: String,
  handle: String
});

module.exports = mongoose.model('Link', LinkSchema);
