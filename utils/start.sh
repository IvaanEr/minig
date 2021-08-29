#!/bin/bash

docker rm -f minig_database

docker build -t minig_database .

docker run -it -p 5431:5432 --name minig_database -d --restart always minig_database
