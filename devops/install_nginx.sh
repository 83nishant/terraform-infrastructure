#!/bin/bash

sudo apt-get update
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

echo "<h3> Terraform in One Shot by TWS <h3>" | sudo tee /var/www/html/index.html
