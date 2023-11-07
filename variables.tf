variable "iris_demo_ec2_instance_details" {
  description = "This is a simple tuple variable used in IRIS Terraform demo session"
  type = tuple([ string, number, bool ])
  default = [ "t2.micro", 2, true ]
}
