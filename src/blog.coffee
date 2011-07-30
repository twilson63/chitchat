express = require 'express'
ck = require 'coffeekup'
posts = []
mongoose = require 'mongoose'
Schema = mongoose.Schema
PostSchema = new Schema
  title: String
  body: String
  posted: 
    type: Date
    default: Date.now

Post = mongoose.model 'Post', PostSchema
mongoose.connect 'mongodb://localhost/chitchat'

app = express.createServer express.logger(), express.bodyParser(), express.methodOverride()

# register view engine
app.register '.coffee', require('coffeekup')
app.set 'view engine', 'coffee'

# index
app.get '/', (req, resp) ->
  Post.find().sort('posted',-1).run (err, posts) -> resp.render 'index', posts: posts
# new
app.get '/new', (req, resp) -> resp.render 'new'
# create
app.post '/', (req, resp) ->
  post = new Post(req.body.post)
  post.save (err, blog) ->
    if err then resp.end err else resp.redirect '/'
# show
app.get '/:id', (req, resp) ->
  Post.findById req.params.id, (err, post) -> resp.render 'show', post: post
# edit
app.get '/:id/edit', (req, resp) ->
  Post.findById req.params.id, (err, post) -> resp.render 'edit', post: post
# update
app.put '/:id', (req, resp) ->
  Post.findById req.params.id, (err, post) ->
    post.title = req.body.post.title
    post.body = req.body.post.body
    post.save (err, post) -> resp.redirect "/#{post.id}"
# delete
app.del '/:id', (req, resp) ->
  Post.findById req.params.id, (err, post) -> post.remove (err) -> resp.redirect '/'
# listen
app.listen Number(process.env.PORT || process.env.VMC_APP_PORT) || 3000, ->
  console.log 'Listening...'

