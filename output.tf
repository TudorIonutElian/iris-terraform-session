output "iris_ec2_instance_ami_filter" {
    description = "I will print AMI ID"
    value = data.aws_ami.iris_ec2_ami_filter.id
}

output "iris_terraform_demo_public_ip" {
  value = aws_instance.iris_ec2_instance_demo.public_ip
}
