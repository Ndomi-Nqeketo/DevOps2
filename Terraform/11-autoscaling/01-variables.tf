variable "instance_type" {
  description = "Default Instance Type"
  type = string
  default = "t3.micro"
}

variable "key" {
  description = "Add key"
  type = string
  default = "live_keys"
}

variable "az" {
  default = "us-east-1a"
}

variable "aws_region" {
  description = "Default region"
  type        = string
  default     = "us-east-1"
}