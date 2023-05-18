variable "nfs_vpc" {
  description = "NFS VPC"
  type = string
  default = "172.0.0.0/24"
}

variable "nfs_sub" {
  description = "NFS Subnet"
  type = string
  default = "172.0.0.0/28"
}

variable "instance" {
  description = "Instance Type"
  type = string
  default = "t2.micro"
}