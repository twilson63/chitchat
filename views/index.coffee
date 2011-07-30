a href: '/new', ->
  "New Post"
  
h2 "Recent Posts"

ul ->
  for post in @posts
    li ->
      h3 post.title
      div post.body
      span ->
        a href: "/#{post.id}", '(show)'
