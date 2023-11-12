output "web_instance_ip" {
    description = "IP Value for public website"
    value = "http://${aws_instance.web.public_ip}/index.html"
}