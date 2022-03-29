#!/bin/bash

composer create-project symfony/skeleton:"^5.4"
mv skeleton/* ./
cd skeleton
mv .env ../
mv .gitignore ../
cd ../
rm -rf skeleton
