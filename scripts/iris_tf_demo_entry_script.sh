d#!/bin/bash
# package updates
#!/bin/bash
  # Use this for your user data (script from top to bottom)
  # install httpd (Linux 2 version)
yum update -y
yum install -y unzip
yum install -y httpd
systemctl start httpd
systemctl enable httpd

cd /var/www/html/
echo '<!DOCTYPE html>' > index.html
echo '<html>' >> index.html
echo '<head>' >> index.html
echo '<title>Simple Ec2 instance on Iris Begginers TF Demo</title>' >> index.html
echo '<meta charset="UTF-8">' >> index.html
echo '</head>' >> index.html
echo '<body>' >> index.html
echo '<h1>Welcome to Iris Terraform Demo</h1>' >> index.html
echo '<h3>Hope you enjoyed!</h3>' >> index.html
echo '</div>' >> index.html
echo '</html>' >> index.html
