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

# Add VPC
resource "aws_vpc" "iris_terraform_demo_vpc" {
  cidr_block = "10.0.0.0/16" # Replace with your desired CIDR block
  tags = {
    Name = "Prod_VPC"
  }
}

resource "aws_internet_gateway" "iris_terraform_demo_gw" {
  vpc_id = aws_vpc.iris_terraform_demo_vpc.id
}

resource "aws_route_table" "iris_terraform_demo_route_table" {
  vpc_id = aws_vpc.iris_terraform_demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.iris_terraform_demo_gw.id
  }
  tags = {
    Name = "prod-RT"
  }
}

resource "aws_subnet" "iris_terraform_demo_subnet" {
  vpc_id            = aws_vpc.iris_terraform_demo_vpc.id
  cidr_block        = "10.0.1.0/24" # Replace with your desired CIDR block
  availability_zone = "eu-central-1a"
  tags = {
    Name = "prod_subnet"
  }
}

resource "aws_route_table_association" "iris_terraform_demo_route_table_asso" {
  subnet_id      = aws_subnet.iris_terraform_demo_subnet.id
  route_table_id = aws_route_table.iris_terraform_demo_route_table.id
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
  name        = "webserver_sg"
  description = "Allow inbound SSH and HTTP traffic"
  vpc_id      = aws_vpc.iris_terraform_demo_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Web-traffic"
  }
}

# Adding ec2 instance configuration
resource "aws_instance" "iris_ec2_instance_demo" {
  ami = data.aws_ami.iris_ec2_ami_filter.id
  #ami = "ami-0766f68f0b06ab145"
  instance_type = var.iris_demo_ec2_instance_details[0]
  key_name = aws_key_pair.iris_terraform_demo_key.key_name
  vpc_security_group_ids  = [ aws_security_group.iris_terraform_demo_vpc.id ]

  user_data = file("./scripts/iris_ec2_entry.sh")

  tags = {
    "IRIS Software Group demo" = var.iris_demo_ec2_instance_details[2]
  }
}
