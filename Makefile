.PHONY: help init-symfony init-docker start-container o-php s-dock vendor up-composer npm-install assets create-bdd map-bdd tests init-dev install-dev up-prod
#docker exec -it --user $USER  php8_symfony_test /bin/bash

# variables
CONTAINER = php8_symfony_hello_mariage
USER_NAME = user
SQLITE_DIR = ./data
SQLITE_NAME = database.sqlite

help: ## Need help ?
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-15s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

init-docker: ## initialisation docker avec docker-compose et/ou lance les containers
ifeq ($(OS), Windows_NT)
	@USER_ID=1000 GROUP_ID=1000 docker-compose up -d
else
	@USER_ID=$(shell id -u) GROUP_ID=$(shell id -g) docker-compose up -d
endif

init-symfony: ## initialisation d'un projet symfony skeleton
	@echo "Install symfony"
	@docker exec --user $(USER_NAME) $(CONTAINER) /bin/bash ./.docker/cmd/install-skeleton.sh
	@echo "Install packages"
	@docker exec --user $(USER_NAME) $(CONTAINER) /bin/bash ./.docker/cmd/install-packages.sh
	@echo "Install node pakages"
	@make npm-install

o-php:## Ouvre le container php
	@docker exec -it $(CONTAINER) /bin/bash

s-dock: ## Stop les containers
	@docker-compose stop

vendor: composer.json ## Installation des packages
	@docker exec --user $(USER_NAME) $(CONTAINER) /bin/bash -c 'composer install'

up-composer: composer.json ## Update des packages
	@docker exec --user $(USER_NAME) $(CONTAINER) /bin/bash -c 'composer update'

npm-install: ## Installation des packages
	@docker exec --user root $(CONTAINER) /bin/bash -c 'npm install'

assets: ## Compilation des assets
	@docker exec --user $(USER_NAME) $(CONTAINER) /bin/bash -c 'npm run dev'

create-bdd: ## create bdd
	@docker exec --user $(USER_NAME) $(CONTAINER) /bin/bash -c 'php bin/console doctrine:database:create'

map-bdd: ## Mapppage de la bdd
	@echo "Migration de la base de données"
	@docker exec --user $(USER_NAME) $(CONTAINER) /bin/bash -c 'php bin/console make:migration; php bin/console --no-interaction doctrine:migrations:migrate'

tests: ## Install la base de test et lance les tests
	@[ -d $(SQLITE_DIR) ] || mkdir -p $(SQLITE_DIR)

ifeq ($(SQLITE_DIR)/$(SQLITE_NAME), $(wildcard $(SQLITE_DIR)/$(SQLITE_NAME)))
	@rm $(SQLITE_DIR)/$(SQLITE_NAME)
endif

	@touch "$(SQLITE_DIR)/$(SQLITE_NAME)"
	@docker exec --user $(USER_NAME) $(CONTAINER) /bin/bash -c 'php bin/console doctrine:schema:update --force --env=test;php bin/console doctrine:fixtures:load --no-interaction --env=test;php ./vendor/bin/phpunit --verbose'

init-dev: vendor npm-install assets create-bdd ## Première installation en dev et installation sans fichier de migration.

install-dev: init-dev map-bdd ## Installation en dev avec des fichiers de migration.

up-prod: ## Mise à jour de la prod
	@echo "Mise à jour"
	php composer.phar install
	php bin/console --no-interaction doctrine:migrations:migrate
	php bin/console cache:clear --env:prod
