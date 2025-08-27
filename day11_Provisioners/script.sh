#!/bin/bash
echo "Hello from Terraform!" | sudo tee /var/www/html/index.html
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd