output "iris_ec2_instance_ami_filter" {
    description = "I will print AMI ID"
    value = data.aws_ami.iris_ec2_ami_filter.id
}
