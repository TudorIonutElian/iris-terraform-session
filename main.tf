# Adding terraform required providers block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Add configuration to authorisation keys
# Configure the AWS Provider
provider "aws" {
  shared_config_files = ["~/.aws/config"]
  shared_credentials_files = [ "~/.aws/credentials" ]
  profile = "default"
}

# Added data source to filter the ami
data "aws_ami" "iris_ec2_ami_filter" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}


# Adding iris terraform_public_key
resource "aws_key_pair" "iris_terraform_demo_key" {
  key_name = "terraform_key_ro"
  public_key = file("./auth_keys/iris_terraform_demo.pub")
}

resource "aws_security_group" "web_security_group" {
  name = "web_security_group"
  description = "Configuration for allowing traffic for 22 and 80 port"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

# Adding ec2 instance configuration
resource "aws_instance" "iris_ec2_instance_demo" {
  ami = data.aws_ami.iris_ec2_ami_filter.id
  #ami = "ami-0766f68f0b06ab145"
  instance_type = var.iris_demo_ec2_instance_details[0]
  count = var.iris_demo_ec2_instance_details[1]
  key_name = aws_key_pair.iris_terraform_demo_key.key_name
  security_groups = [ "web_security_group" ]

  user_data = file("scripts/iris_ec2_entry.sh")

  tags = {
    "IRIS Software Group demo" = var.iris_demo_ec2_instance_details[2]
  }
}
