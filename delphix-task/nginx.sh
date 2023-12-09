#!/bin/bash

sudo apt update -y
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx

sudo echo "Welcome to my Delphix Interview Exercise" >> /var/www/html/index.html
