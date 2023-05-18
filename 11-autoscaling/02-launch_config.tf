module "networking" {
  source = "../01-network"
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  owners = ["amazon"]
}


resource "aws_launch_configuration" "launch_config" {
  image_id = data.aws_ami.amazon-linux-2.id
  instance_type = var.instance_type
  name = "webserver"
  security_groups = [module.networking.SSHsecurityGroupID, module.networking.WEBsecurityGroupID]
  key_name = var.key
  user_data = file("${path.module}/apache.sh")
}

resource "aws_autoscaling_group" "ASG" {
  launch_configuration = aws_launch_configuration.launch_config.id
  vpc_zone_identifier = [module.networking.subnet_id]

  max_size = 3
  min_size = 1
  desired_capacity = 1

  health_check_grace_period = 300
  health_check_type = "EC2"

  tag {
    key = "Name"
    propagate_at_launch = true
    value = "ASG"
  }
}

# -----------------------
# Scaling up
# -----------------------

resource "aws_autoscaling_policy" "agent-scale-up" {
  name = "webserver_policy"
  autoscaling_group_name = aws_autoscaling_group.ASG.name
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpualert" {
  alarm_name = "terraform-cpu-alert"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 60
  statistic = "Average"
  threshold = "60"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ASG.name
  }

  actions_enabled = true
  alarm_description = "This metric monitor EC2 instance cpu utilization"
  alarm_actions = [aws_autoscaling_policy.agent-scale-up.arn]
}

# -----------------------
# Scaling down
# -----------------------
resource "aws_autoscaling_policy" "agent-scale-down" {
  name = "webserver_policy"
  autoscaling_group_name = aws_autoscaling_group.ASG.name
  scaling_adjustment = "-1"
  adjustment_type = "ChangeInCapacity"
  policy_type = "SimpleScaling"
  cooldown = 60
}

resource "aws_cloudwatch_metric_alarm" "cpualarm-down" {
  alarm_name = "terraform-alarm-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 60
  statistic = "Average"
  threshold = "30"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ASG.name
  }

  actions_enabled = true
  alarm_description = "This metric monitor EC2 instance cpu utilization"
  alarm_actions = [aws_autoscaling_policy.agent-scale-down.arn]
}