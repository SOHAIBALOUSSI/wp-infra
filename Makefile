
COMPOSE_FILE = srcs/docker-compose.yml


install:
	mkdir -p ~/sait-alo/data/wordpress ~/sait-alo/data/mariadb
	docker compose -f $(COMPOSE_FILE) up -d --build

finstall:
	sudo rm -rf ~/sait-alo/
	docker compose -f $(COMPOSE_FILE) down -v
	docker compose -f $(COMPOSE_FILE) down --rmi all
	mkdir -p ~/sait-alo/data/wordpress ~/sait-alo/data/mariadb
	docker compose -f $(COMPOSE_FILE) up -d --build

down:
	docker compose -f $(COMPOSE_FILE) down -v

up:
	docker compose -f $(COMPOSE_FILE) up