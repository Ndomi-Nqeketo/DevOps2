variable "region" {
  type    = string
  default = "us-east-1"
}

variable "project" {
  description = "The project this belongs to"
  type        = string
  default     = "caching"
}

variable "environment" {
  description = "How do you want to call your environment"
  type        = string
  default     = "dev"
}

variable "name" {
  description = "The name of the redis cluster"
  type        = string
  default     = "redis-cluster"
}

variable "engine_version" {
  description = "The redis engine version"
  type        = string
  default     = "7.0"
}

variable "port" {
  description = "The redis port"
  default     = 6379
  type        = number
}

variable "node_type" {
  description = "The instance size of the redis cluster"
  type        = string
  default     = "cache.t3.small"
}

variable "num_cache_nodes" {
  description = "The number of cache nodes"
  type        = number
  default     = 2
}

variable "parameter_group_name" {
  description = "The parameter group name"
  default     = "default.redis7"
  type        = string
}

variable "vpc_cidr" {
  default     = "10.1.0.0/25"
  description = "redis vpc"
}

variable "availability_zones_count" {
  description = "The number AZs"
  type        = number
  default     = 2
}

variable "subnet_cidr_bits" {
  description = "The number of subnet bits for the CIDR. For example, specifying a value 8 for this parameter will create a CIDR with a mask of /24."
  type        = number
  default     = 2
}

variable "automatic_failover_enabled" {
  default = true
  type    = bool
}

variable "snapshot_window" {
  description = "The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. The minimum maintenance window is a 60 minute period. Example: 05:00-09:00"
  default     = "03:00-05:00"
  type        = string
}

variable "snapshot_retention_limit" {
  description = "The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot_retention_limit is not supported on cache.t1.micro or cache.t2.* cache nodes"
  default     = 7
  type        = number
}

variable "multi_az_enabled" {
  default = true
  type    = bool
}

variable "at_rest_encryption_enabled" {
  description = "(Optional) Whether to enable encryption at rest"
  default     = true
  type        = bool
}

variable "transit_encryption_enabled" {
  description = "(Optional) Whether to enable encryption in transit"
  default     = true
  type        = bool
}

variable "az_1" {
  description = "Availability zone 1"
  type = string
  default = "us-east-1a"
}

variable "az_2" {
  description = "Availability zone 2"
  type = string
  default = "us-east-1b"
}