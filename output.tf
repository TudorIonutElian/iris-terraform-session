output "web_instance_ip" {
    description = "IP Value for public website"
    value = "http://${aws_instance.iris_tf_demo_ec2_instance.public_ip}/index.html"
}