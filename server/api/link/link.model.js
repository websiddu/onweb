'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var LinkSchema = new Schema({
  name: String,
  url: String,
  icon: String
});

module.exports = mongoose.model('Link', LinkSchema);
