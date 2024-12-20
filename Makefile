# Load environment variables from .env file
include srcs/.env

COMPOSE = docker-compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE)

# Define the targets explicitly to avoid conflicts with potential filenames
.PHONY: all build up down re clean fclean status logs get-user

# Default target to run setup, build, and start containers
all: get-user build up

# Set the USER variable in the .env file to the current user
get-user:
	@sed -i 's/^USER=.*/USER=$(shell whoami)/' srcs/.env
	@sed -i 's/^DOMAIN_NAME=.*/DOMAIN_NAME=$(shell whoami).42.fr/' srcs/.env
	
# Build Docker images
build: get-user
	@mkdir -p /home/${USER}/${MARIADB_VOLUME}
	@mkdir -p /home/${USER}/${WORDPRESS_VOLUME}
	@echo "$(GREEN)Building Docker images...$(RESET)"
	$(COMPOSE) build

# Start containers
up: get-user
	@echo "$(GREEN)Starting containers...$(RESET)"
	$(COMPOSE) up -d

# Stop containers
down:
	@echo "$(RED)Stopping containers...$(RESET)"
	$(COMPOSE) down

# Remove containers and networks, but keep volumes
clean:
	@echo "$(RED)Removing containers and networks...$(RESET)"
	$(COMPOSE) down
	@docker system prune -af

# Remove containers, networks, and volumes
fclean: clean get-user
	@echo "$(RED)WARNING: This will delete all data in the volumes!$(RESET)"
	@read -p "Are you sure? (Y/n): " confirm && [ "$$confirm" = "Y" ] || exit
	@docker volume prune -f
	@sudo rm -rf /home/${USER}/${MARIADB_VOLUME}
	@sudo rm -rf /home/${USER}/${WORDPRESS_VOLUME}

# Rebuild and restart containers
re: down build up

# Check container status
status:
	$(COMPOSE) ps

# View container logs
logs:
	$(COMPOSE) logs -f || true

# Rule to print the main process for each container
CONTAINERS := nginx wp-php mariadb static_site redis adminer
print-pid1:
	@for container in $(CONTAINERS); do \
		docker exec -it $$container cat /proc/1/cmdline || echo "Error: $$container is not running"; \
		echo ""; \
	done
