h2 "New Post"

form action: '/', method: 'POST', ->
  p ->
    label for: 'title', -> 'Title'
    br()
    input id: 'title', name: 'post[title]'
  p ->
    label for: 'body', -> 'Body'
    br()
    textarea id: 'body', name: 'post[body]'
  p ->
    input type: 'submit', value: 'Create'
  p ->
    a href: '/', 'Return Home'