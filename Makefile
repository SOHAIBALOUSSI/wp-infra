
COMPOSE_FILE = srcs/docker-compose.yml


install:
	sudo mkdir -p /home/sait-alo/data/wordpress /home/sait-alo/data/mariadb
	docker compose -f $(COMPOSE_FILE) up -d --build

finstall:
	sudo rm -rf /home/sait-alo/
	docker compose -f $(COMPOSE_FILE) down -v
	docker compose -f $(COMPOSE_FILE) down --rmi all
	sudo mkdir -p /home/sait-alo/data/wordpress /home/sait-alo/data/mariadb
	docker compose -f $(COMPOSE_FILE) up -d --build

down:
	docker compose -f $(COMPOSE_FILE) down -v

up:
	docker compose -f $(COMPOSE_FILE) up