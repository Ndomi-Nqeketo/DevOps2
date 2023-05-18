variable "bucket_prefix" {
  default = "config"
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
  default     = "225908212644"
}

variable "aws_region" {
  description = "Default region"
  type        = string
  default     = "us-east-1"
}

variable "bucket_key_prefix" {
  default = "config"
}

variable "sns_topic_arn" {
  default = "arn:aws:sns:us-east-1:225908212644:MyTopic"
}

variable "ami_id" {
  description = "Approved AMI ID"
  type = string
  default = "ami-04902260ca3d33422"
}

variable "key" {
  description = "Add key"
  type = string
  default = "live_keys"
}