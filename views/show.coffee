h2 'Show Post'

h3 @post.title

p "Posted: #{@post.posted}"

div @post.body

ul ->
  li ->
    a href: "/", "Home"
  li ->
    a href: "/#{@post.id}/edit", "Edit"
  li ->
    form action: "/#{@post.id}", method: 'POST', ->
      input type:'hidden', name: '_method', value: 'delete'
      button "Delete"
