#!/bin/bash

# packages with -n for docker ask
# Tools bar
composer require --dev symfony/profiler-pack

# Api platform
composer require api

# doctrine
composer require symfony/orm-pack

# maker
composer require --dev symfony/maker-bundle

# twig
composer require twig

# tests and fixtures
composer require --dev phpunit/phpunit symfony/test-pack
composer require --dev orm-fixtures
composer require --dev symfony/http-client justinrainbow/json-schema symfony/browser-kit

# webpack
composer require symfony/webpack-encore-bundle

# paginator
composer require knplabs/knp-paginator-bundle
