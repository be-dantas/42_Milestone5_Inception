name = inception

all: build up

build:
	mkdir -p /home/bedantas/data/mariadb
	mkdir -p /home/bedantas/data/wordpress
	docker compose -f srcs/docker-compose.yml build

up:
	docker compose -f srcs/docker-compose.yml up -d

down:
	docker compose -f srcs/docker-compose.yml down

clean:
	docker compose -f srcs/docker-compose.yml down -v --rmi all --remove-orphans

fclean: clean
	docker system prune -af --volumes
	@docker run --rm -v /home/bedantas/data:/data debian:bookworm-slim sh -c "rm -rf /data/mariadb/* /data/wordpress/*"

re: fclean all

.PHONY: all build up down clean fclean re