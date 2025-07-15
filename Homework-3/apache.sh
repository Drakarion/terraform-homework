#!/bin/bash
sudo apt update -y || sudo yum update -y
sudo apt install -y apache2 || sudo yum install -y httpd
sudo systemctl start apache2 || sudo systemctl start httpd
sudo systemctl enable apache2 || sudo systemctl enable httpd
echo "Hello from $(hostname)" > /var/www/html/index.html