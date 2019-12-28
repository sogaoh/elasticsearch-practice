.PHONY:

help:
		cat Makefile

up:
		docker-compose up -d

upb:
		docker-compose up -d --build

bd:
		docker-compose build

rbd:
		docker-compose build --no-cache


rs:
		docker-compose restart

down:
		docker-compose down

#clean-up:
		#docker system prune	# --volumes
		#docker images -aq | xargs docker rmi -f
		#docker volume rm $(docker volume ls --filter dangling=true -q)