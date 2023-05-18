variable "instance_type" {
  description = "Instance Type"
  type = string
  default = "t3.micro"
}

variable "aws_region" {
  description = "Default region"
  type = string
  default = "us-east-1"
}

variable "key" {
  description = "Add key"
  type = string
  default = "live_keys"
}