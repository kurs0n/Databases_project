# Variables
DOCKER_IMAGE = postgres
DOCKER_CONTAINER = pgsql-dev
DOCKER_PASSWORD = bazy
DOCKER_PORT = 5432
MIGRATIONS_DIR = migrations
MIGRATION_TARGET = /migrations
DOCKER_USER = postgres

# Helper function to check if a container exists
container_exists = $(shell docker container inspect $(DOCKER_CONTAINER) > /dev/null 2>&1 && echo true || echo false)


# Targets
pull_image:
	docker pull $(DOCKER_IMAGE)

run_container: pull_image
	docker rm -f $(DOCKER_CONTAINER) || true
	docker run --name $(DOCKER_CONTAINER) \
		-e POSTGRES_PASSWORD=$(DOCKER_PASSWORD) \
		-p $(DOCKER_PORT):$(DOCKER_PORT) $(DOCKER_IMAGE)

exec_database:
	docker exec -it $(DOCKER_CONTAINER) psql -U $(DOCKER_USER)

migrate_files:
	docker cp ./$(MIGRATIONS_DIR)/. $(DOCKER_CONTAINER):$(MIGRATION_TARGET)
	docker exec -i $(DOCKER_CONTAINER) bash -c ' \
        set -e; \
        find $(MIGRATION_TARGET) -type f -name "*.sql" | sort -V | while IFS= read -r FILE; do \
          echo "Applying migration: $$FILE"; \
          if psql -U $(DOCKER_USER) -f "$$FILE"; then \
             echo "SUCCESS: Applied migration: $$FILE"; \
          else \
            echo "ERROR: Failed to apply migration: $$FILE"; \
            exit 1; \
          fi; \
        done \
    '

exec_shell:
	docker exec -it $(DOCKER_CONTAINER) bash

stop_container:
	docker stop $(DOCKER_CONTAINER)

remove_container:
	docker rm $(DOCKER_CONTAINER)

clean_all: remove_container

.PHONY: pull_image run_container exec_database migrate_files exec_shell stop_container remove_container clean_all