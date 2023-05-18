module "monitoring" {
  source = "../03-Logging"
}

module "cw_metric_filter" {
  source = "../06-cloudwatch_metrics_filter"
}

module "cloudtrail-trail" {
  source = "../07-cloudtrail_trials"
}

module "aws-config" {
  source = "../08-awsconfig"
}

module "s3-bucket" {
  source = "../09-s3_bucket"
}

module "nfs" {
  source = "../10-EFS"
}

#module "users" {
#  source = "../04-users"
#}