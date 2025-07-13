
COMPOSE_FILE = srcs/docker-compose.yml


install:
	mkdir -p ./data/wordpress ./data/mariadb
	docker compose -f $(COMPOSE_FILE) up -d --build

re:
	rm -rf ./data/
	docker compose -f $(COMPOSE_FILE) down -v
	docker compose -f $(COMPOSE_FILE) down --rmi all
	mkdir -p ./data/wordpress ./data/mariadb
	docker compose -f $(COMPOSE_FILE) up -d --build

down:
	docker compose -f $(COMPOSE_FILE) down -v
clean:
	docker compose -f $(COMPOSE_FILE) down -v --remove-orphans
	docker system prune -f
	# Clean data directories using Docker container to handle permission issues
	docker run --rm -v $(PWD)/data:/data alpine:3.21.3 sh -c "rm -rf /data/wordpress/* /data/mariadb/* 2>/dev/null || true"
	@echo "Data directories cleaned"

up:
	docker compose -f $(COMPOSE_FILE) up