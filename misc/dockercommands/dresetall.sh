#!/usr/bin/env bash

# kill all the running containers
docker kill $(docker ps -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
#remove all the volumes
docker volume rm $(docker volume ls -q)
#remove all the networks
docker network rm $(docker network ls -q)
#remove all the containers
docker container prune -f
#remove all the images
docker image prune -f
