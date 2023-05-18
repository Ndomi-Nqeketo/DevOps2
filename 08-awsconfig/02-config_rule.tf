# -----------------------------------------------------------
# set up a role for the Configuration Recorder to use
# -----------------------------------------------------------
resource "aws_iam_role" "role" {
  name = "my-awsconfig-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "role_att" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}

# -----------------------------------------------------------
# set up a bucket for the Configuration Recorder to write to
# -----------------------------------------------------------
resource "aws_s3_bucket" "bucket" {
  bucket_prefix = var.bucket_prefix
  acl           = "private"
  # region        = var.aws_region

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }

  lifecycle_rule {
    enabled = true
    prefix  = "${var.bucket_key_prefix}/"
  }

  # expiration {
  #   days = 365
  # }

  # noncurrent_version_expiration {
  #   days = 365
  # }
}

resource "aws_s3_bucket_policy" "config_bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Allow bucket ACL check",
      "Effect": "Allow",
      "Principal": {
        "Service": [
         "config.amazonaws.com"
        ]
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "${aws_s3_bucket.bucket.arn}",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "true"
        }
      }
    },
    {
      "Sid": "Allow bucket write",
      "Effect": "Allow",
      "Principal": {
        "Service": [
         "config.amazonaws.com"
        ]
      },
      "Action": "s3:PutObject",
      "Resource": "${aws_s3_bucket.bucket.arn}/${var.bucket_key_prefix}/AWSLogs/${var.aws_account_id}/Config/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        },
        "Bool": {
          "aws:SecureTransport": "true"
        }
      }
    },
    {
      "Sid": "Require SSL",
      "Effect": "Deny",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:*",
      "Resource": "${aws_s3_bucket.bucket.arn}/*",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    }
  ]
}
POLICY
}

# -----------------------------------------------------------
# set up the  Config Recorder
# -----------------------------------------------------------

resource "aws_config_configuration_recorder" "recoder" {
  name     = "config-recorder"
  role_arn = aws_iam_role.role.arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "delivery" {
  name           = "config-delivery"
  s3_bucket_name = aws_s3_bucket.bucket.bucket
  s3_key_prefix  = var.bucket_key_prefix
  sns_topic_arn  = var.sns_topic_arn

  snapshot_delivery_properties {
    delivery_frequency = "Three_Hours"
  }

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_configuration_recorder_status" "recorder_status" {
  name       = aws_config_configuration_recorder.recoder.name
  is_enabled = true

  depends_on = [
    aws_config_delivery_channel.delivery
  ]
}

# -----------------------------------------------------------
# set up the Config Recorder rules
# -----------------------------------------------------------
resource "aws_config_config_rule" "instance_in_vpc" {
  name = "instances_in_vpc"

  source {
    owner             = "AWS"
    source_identifier = "INSTANCES_IN_VPC"
  }

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_config_rule" "ec2_volume_inuse_check" {
  name = "ec2_volume_inuse_check"

  source {
    owner             = "AWS"
    source_identifier = "EC2_VOLUME_INUSE_CHECK"
  }

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_config_rule" "eip_attached" {
  name = "eip_attached"

  scope {
    compliance_resource_types = [
      "AWS::EC2::EIP"
    ]
  }

  source {
    owner             = "AWS"
    source_identifier = "EIP_ATTACHED"
  }

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_config_rule" "encrypted_volumes" {
  name = "encrypted_volumes"

  source {
    owner             = "AWS"
    source_identifier = "ENCRYPTED_VOLUMES"
  }

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_config_rule" "incoming_ssh_disabled" {
  name = "incoming_ssh_disabled"

  source {
    owner             = "AWS"
    source_identifier = "INCOMING_SSH_DISABLED"
  }

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_config_rule" "cloud_trail_enabled" {
  name = "cloud_trail_enabled"

  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_ENABLED"
  }

  input_parameters = <<EOF
{
  "s3BucketName": "cloudformation1012"
}
EOF

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_config_rule" "cloudwatch_alarm_action_check" {
  name = "cloudwatch_alarm_action_check"

  source {
    owner             = "AWS"
    source_identifier = "CLOUDWATCH_ALARM_ACTION_CHECK"
  }

  input_parameters = <<EOF
{
  "alarmActionRequired" : "true",
  "insufficientDataActionRequired" : "false",
  "okActionRequired" : "false"
}
EOF

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_config_rule" "iam_group_has_users_check" {
  name = "iam_group_has_users_check"

  source {
    owner             = "AWS"
    source_identifier = "IAM_GROUP_HAS_USERS_CHECK"
  }

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_config_rule" "iam_password_policy" {
  name = "iam_password_policy"

  source {
    owner             = "AWS"
    source_identifier = "IAM_PASSWORD_POLICY"
  }

  input_parameters = <<EOF
{
  "RequireUppercaseCharacters" : "true",
  "RequireLowercaseCharacters" : "true",
  "RequireSymbols" : "true",
  "RequireNumbers" : "true",
  "MinimumPasswordLength" : "16",
  "PasswordReusePrevention" : "12",
  "MaxPasswordAge" : "90"
}
EOF

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_config_rule" "iam_user_group_membership_check" {
  name = "iam_user_group_membership_check"

  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_GROUP_MEMBERSHIP_CHECK"
  }

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_config_rule" "iam_user_no_policies_check" {
  name = "iam_user_no_policies_check"

  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_NO_POLICIES_CHECK"
  }

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_config_rule" "root_account_mfa_enabled" {
  name = "root_account_mfa_enabled"

  source {
    owner             = "AWS"
    source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
  }

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_config_rule" "s3_bucket_public_read_prohibited" {
  name = "s3_bucket_public_read_prohibited"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  }

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_config_rule" "s3_bucket_public_write_prohibited" {
  name = "s3_bucket_public_write_prohibited"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
  }

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_config_rule" "s3_bucket_ssl_requests_only" {
  name = "s3_bucket_ssl_requests_only"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_SSL_REQUESTS_ONLY"
  }

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_config_rule" "s3_bucket_server_side_encryption_enabled" {
  name = "s3_bucket_server_side_encryption_enabled"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
  }

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_config_rule" "s3_bucket_versioning_enabled" {
  name = "s3_bucket_versioning_enabled"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_VERSIONING_ENABLED"
  }

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_config_rule" "ebs_optimized_instance" {
  name = "ebs_optimized_instance"
  description = "Checks whether EBS optimization is enabled for your EC2 instances that can be EBS-optimized."

  scope {
    compliance_resource_types = [
      "AWS::EC2::Instance"
    ]
  }

  source {
    owner             = "AWS"
    source_identifier = "EBS_OPTIMIZED_INSTANCE"
  }

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}

resource "aws_config_config_rule" "account_part_of_organizations" {

  name        = "account-part-of-organizations"
  description = "Rule checks whether AWS account is part of AWS Organizations. The rule is NON_COMPLIANT if the AWS account is not part of AWS Organizations or AWS Organizations master account ID does not match rule parameter MasterAccountId."

  source {
    owner             = "AWS"
    source_identifier = "ACCOUNT_PART_OF_ORGANIZATIONS"
  }

  input_parameters = "{}"

  maximum_execution_frequency = "TwentyFour_Hours"

  depends_on = [
    aws_config_configuration_recorder.recoder
  ]
}