#!/bin/bash
# package updates
sudo yum check-update
sudo yum update 

# apache installation, enabling and status check
sudo yum -y install httpd
sudo systemctl start httpd
sudo systemctl enable httpd

cd /var/www/html/
echo '<!DOCTYPE html>' > index.html
echo '<html>' >> index.html
echo '<head>' >> index.html
echo '<title>Level It Up</title>' >> index.html
echo '<meta charset="UTF-8">' >> index.html
echo '</head>' >> index.html
echo '<body>' >> index.html
echo '<h1>Welcome to Iris Terraform Demo</h1>' >> index.html
echo '<h3>Hope you enjoyed!</h3>' >> index.html
echo '</body>' >> index.html
echo '</html>' >> index.html
