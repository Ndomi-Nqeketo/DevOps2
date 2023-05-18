variable "vpc_cidr" {
    description = "VPC Cidr"
    type = string
    default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "Subnet Cidr"
  type = string
  default = "10.0.0.0/24"
}

variable "az" {
  description = "Availability zone"
  type = string
  default = "us-east-1a"
}

variable "internet_ip" {
  description = "Internet IP"
  type = string
  default = "0.0.0.0/0"
}

variable "aws_region" {
  description = "Region in which AWS Resource to be created"
  type = string
  default = "us-east-1"
}