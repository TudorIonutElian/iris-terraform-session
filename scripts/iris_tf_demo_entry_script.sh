#!/bin/bash
# package updates
#!/bin/bash
  # Use this for your user data (script from top to bottom)
  # install httpd (Linux 2 version)
yum update -y
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
echo '<div style="display:flex; flex-direction:row; align-items: center; justify-content: center; background-color: blue; color: #fff;">' >> index.html
echo '<div><h1>Welcome to Iris Terraform Demo</h1></div>' >> index.html
echo '<div><h3>Hope you enjoyed!</h3></div>' >> index.html
echo '</div>' >> index.html
echo '</html>' >> index.html
