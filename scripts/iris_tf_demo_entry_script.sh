#!/bin/bash
# package updates
#!/bin/bash
  # Use this for your user data (script from top to bottom)
  # install httpd (Linux 2 version)
yum update -y
yum install -y httpd
yum install -y git
systemctl start httpd
systemctl enable httpd

cd /var/www/html/

git clone https://github.com/TudorIonutElian/sample-iris-demo-website.git

cp sample-iris-demo-website/index.html /var/www/html/index.html
