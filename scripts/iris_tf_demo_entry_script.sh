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

################################################
# Go to html directory
################################################
cd /var/www/html/

################################################
# Clone demo website
################################################
git clone https://github.com/TudorIonutElian/sample-iris-demo-website.git

################################################
# Move index.html to public
################################################
mv sample-iris-demo-website/* .

################################################
# Delete old directory
################################################
rm -r sample-iris-demo-website
