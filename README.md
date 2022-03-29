# Hello mariage

Site Api et back-office pour présenter des thèmes de mariage

## Environement de développement

### Pré-requis

* Linux/macos
* Git
* Docker
* Docker-compose

Pour les environements Windows :
* l'installation de make est recommandé.
* les commande "make help" et "make tests" ne sont pas compatibles.

### installation nouveau projet symfony

* Créer le dossier du projet.
* Copier le dossier .docker, Makefile et docker-compose.yaml dans le repertoire du projet.
* Adapter les fichiers docker suivant le besoin
* Lancer la commande : 
```bash
make init-docker
```
* Adapter suivant les besoins du projet :
    * docker/cmd/install-skeleton.sh : la version de symfony
    * docker/cmd/install-packages.sh : commande des packages à installer
* Lancer la commande :
```bash
make init-symfony
```
* Modifier .env et .env.test ou autre fichier suivant le besoin
* Lancer la commande :
```bash
init-dev
```

### Installation en cours de développement

Copier le dépô st "https://github.com/ericJaslet/hello-mariage"
Lancer docker.
Lancer la commande
```bash
make init-docker
```
puis : (si aucun fichier de migration utiliser la commande init-dev) :
```bash
make install-dev
```

Accès base de données sur http://localhost:8080/
Accès symfony sur sur http://localhost:8081/
Documentation de l'api : http://localhost:8081/api

### Mise à jour des assets

Lancer la commande :
```bash
make assets
```

### Mise à jour de la base de données

Lancer la commande
```bash
make map-bdd
```

## Environement de production

### Pré-requis

* linux
* apache
* ">=php8.0"
* base de données sql (pour mysql >=5.6)

### Installation

Copier le dépôt "https://github.com/ericJaslet/hello-mariage"
Mettre à jour le fichier .env suivant les informations de la base de données
Ne plus le suivre avec Git "git rm --cached .env"
Installer composer(composer.phar) dans le dossier
Lancer la commande :
```bash
make up-prod
```

### Mise à jour

Lancer la commande
```bash
make up-prod
```
