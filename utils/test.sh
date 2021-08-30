curl -F 'image=@./26043984b91f3bfd718269e8df16676d.jpg' -F 'customer_id=1' -F 'description=A nice description' http://localhost:4000/minig/v1/post

curl http://localhost:4000/minig/v1/post
curl http://localhost:4000/minig/v1/post?page_number=1&page_size=10
curl http://localhost:4000/minig/v1/post/1
curl
curl --request PATCH http://localhost:4000/minig/v1/post/1/1/like
