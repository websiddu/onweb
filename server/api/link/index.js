'use strict';

var express = require('express');
var controller = require('./link.controller');
var config = require('../../config/environment');
var auth = require('../../auth/auth.service');

var router = express.Router();

router.get('/', auth.isAuthenticated(), controller.index);
router.get('/:id', auth.isAuthenticated(), controller.show);
router.post('/',  auth.isAuthenticated(),controller.create);
router.put('/u', auth.isAuthenticated(), controller.updateuserlink);
//router.post('/u/:id', controller.updateuserlink);
//router.put('/:id', controller.update);
//router.patch('/:id', controller.update);
router.delete('/:id', auth.isAuthenticated(), controller.destroy);



module.exports = router;
