docker rmi -f $(docker images -a -q) || $(docker images -a -q)

