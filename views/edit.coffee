h2 "Edit Post"

form action: "/#{@post.id}", method: 'POST', ->
  input type: 'hidden', name: '_method', value: 'put'
  p ->
    label for: 'title', -> 'Title'
    br()
    input id: 'title', name: 'post[title]', value: @post.title
  p ->
    label for: 'body', -> 'Body'
    br()
    textarea id: 'body', name: 'post[body]', ->
      @post.body
  p ->
    input type: 'submit', value: 'Update'
  p ->
    a href: "/#{@post.id}", 'Back'