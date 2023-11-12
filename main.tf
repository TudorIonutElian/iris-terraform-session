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
data "aws_ami" "iris_tf_demo_ec2_ami_filter" {
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

resource "aws_key_pair" "iris_tf_demo_key_pair" {
  key_name   = "deployer-key"
  public_key = file("auth_keys/iris-tf-demo.pub")
}


resource "aws_instance" "web" {
  ami = data.aws_ami.iris_tf_demo_ec2_ami_filter.id
  instance_type   = "t2.micro"

  user_data = file("scripts/iris_tf_demo_entry_script.sh")

  tags = {
    Name = "web_instance"
  }

  volume_tags = {
    Name = "web_instance"
  } 
}