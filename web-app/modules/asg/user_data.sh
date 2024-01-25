#!/bin/bash
sudo apt update -y
sudo apt-get install nginx -y
sudo cp /var/www/html/index.nginx-debian.html /var/www/html/index.nginx-debian.html.bkp
echo "HelloWorld from $(hostname -f)" | sudo tee /var/www/html/index.nginx-debian.html
sudo systemctl enable nginx
sudo systemctl start nginx 
