(function() {
  var Post, PostSchema, Schema, app, ck, express, mongoose, posts;
  express = require('express');
  ck = require('coffeekup');
  posts = [];
  mongoose = require('mongoose');
  Schema = mongoose.Schema;
  PostSchema = new Schema({
    title: String,
    body: String,
    posted: {
      type: Date,
      "default": Date.now
    }
  });
  Post = mongoose.model('Post', PostSchema);
  mongoose.connect('mongodb://localhost/chitchat');
  app = express.createServer(express.logger(), express.bodyParser(), express.methodOverride());
  app.register('.coffee', require('coffeekup'));
  app.set('view engine', 'coffee');
  app.get('/', function(req, resp) {
    return Post.find().sort('posted', -1).run(function(err, posts) {
      return resp.render('index', {
        posts: posts
      });
    });
  });
  app.get('/new', function(req, resp) {
    return resp.render('new');
  });
  app.post('/', function(req, resp) {
    var post;
    post = new Post(req.body.post);
    return post.save(function(err, blog) {
      if (err) {
        return resp.end(err);
      } else {
        return resp.redirect('/');
      }
    });
  });
  app.get('/:id', function(req, resp) {
    return Post.findById(req.params.id, function(err, post) {
      return resp.render('show', {
        post: post
      });
    });
  });
  app.get('/:id/edit', function(req, resp) {
    return Post.findById(req.params.id, function(err, post) {
      return resp.render('edit', {
        post: post
      });
    });
  });
  app.put('/:id', function(req, resp) {
    return Post.findById(req.params.id, function(err, post) {
      post.title = req.body.post.title;
      post.body = req.body.post.body;
      return post.save(function(err, post) {
        return resp.redirect("/" + post.id);
      });
    });
  });
  app.del('/:id', function(req, resp) {
    return Post.findById(req.params.id, function(err, post) {
      return post.remove(function(err) {
        return resp.redirect('/');
      });
    });
  });
  app.listen(Number(process.env.PORT || process.env.VMC_APP_PORT) || 3000, function() {
    return console.log('Listening...');
  });
}).call(this);
