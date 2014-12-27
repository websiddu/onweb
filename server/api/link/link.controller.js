'use strict';

var _ = require('lodash');
var Link = require('./link.model');
var User = require('../user/user.model');
var mongoose = require('mongoose');

// Get list of links
exports.index = function(req, res) {
  Link.find(function (err, links) {
    if(err) { return handleError(res, err); }
    return res.json(200, links);
  });
};

// Get a single link
exports.show = function(req, res) {
  Link.findById(req.params.id, function (err, link) {
    if(err) { return handleError(res, err); }
    if(!link) { return res.send(404); }
    return res.json(link);
  });
};

// Creates a new link in the DB.
exports.create = function(req, res) {
  Link.create(req.body, function(err, link) {
    if(err) { return handleError(res, err); }
    return res.json(201, link);
  });
};

// Updates an existing link in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Link.findById(req.params.id, function (err, link) {
    if (err) { return handleError(res, err); }
    if(!link) { return res.send(404); }
    var updated = _.merge(link, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.json(200, link);
    });
  });
};


exports.updateuserlink = function(req, res) {
  //if(req.body._id) { delete req.body._id; }

  var userId = req.user._id;
  var link = req.body.data;

  var linkId = link._id || mongoose.Types.ObjectId();
  delete link._id

  Link.update({
      _id: linkId
    }, link, {
      upsert: true
    })
    .exec(function(err, lnk) {
      if(!_.contains(req.user.links, linkId)) {
        User.findById(userId, function(err, usr){
          usr.links.push(linkId)
          usr.save(function(err, usr) {

          })
        });
      }

      link._id = linkId
      return res.json(200, link);

    });




  // Link.findById(req.params.id, function (err, link) {
  //   if (err) { return handleError(res, err); }
  //   if(!link) { return res.send(404); }
  //   var updated = _.merge(link, req.body);
  //   updated.save(function (err) {
  //     if (err) { return handleError(res, err); }
  //     return res.json(200, link);
  //   });
  // });


};


// Deletes a link from the DB.
exports.destroy = function(req, res) {

  var userId = req.user._id;
  var linkId = req.params.id;

  Link.findById(req.params.id, function (err, link) {
    if(err) { return handleError(res, err); }
    if(!link) { return res.send(404); }
    link.remove(function(err) {
      if(err) { return handleError(res, err); }

      if(!_.contains(req.user.links, linkId)) {
        User.findById(userId, function(err, usr){
          usr.links = _.remove(usr.links, linkId)
          usr.save(function(err, usr) {
            return res.send(204);
          })
        });
      }

    });
  });
};

function handleError(res, err) {
  return res.send(500, err);
}
