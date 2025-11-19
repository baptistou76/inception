NAME = inception

DOCKER_COMPOSE = docker compose -f srcs/docker-compose.yml

all: build up

build:
	@$(DOCKER_COMPOSE) build

up:
	@$(DOCKER_COMPOSE) up -d

down:
	@$(DOCKER_COMPOSE) down

clean: down
	@docker system prune -af --volumes

re: down all

.PHONY: all build up down clean re