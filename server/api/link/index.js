'use strict';

var express = require('express');
var controller = require('./link.controller');
var config = require('../../config/environment');
var auth = require('../../auth/auth.service');

var router = express.Router();

router.get('/', controller.index);
router.get('/:id', controller.show);
router.post('/', controller.create);
router.put('/u', auth.isAuthenticated(), controller.updateuserlink);
//router.post('/u/:id', controller.updateuserlink);
//router.put('/:id', controller.update);
//router.patch('/:id', controller.update);
router.delete('/:id', controller.destroy);



module.exports = router;
