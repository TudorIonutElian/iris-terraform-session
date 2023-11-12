variable instance_type {
    description = "Value for the ec2 instance type"
    default = "t2.micro"
}

variable entry_script_path {
    description = "Path value for entry script"
    default = "scripts/iris_tf_demo_entry_script.sh"
}

variable "ami_owner" {
    description = "Value for AMI owner"
    default = "amazon"
}