module "computer" {
  source = "../02-compute"
}

resource "aws_cloudwatch_dashboard" "CPU_Utils" {
  dashboard_name = "EC2-CloudWatch-Dashboard"
  dashboard_body = <<EOF
{
    "widgets": [
        {
            "height": 6,
            "width": 9,
            "y": 0,
            "x": 0,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/EC2", "CPUUtilization", "InstanceId", "${module.computer.Instance_id}", { "id": "m1" } ],
                    [ { "expression": "ANOMALY_DETECTION_BAND(m1, 2)", "label": "CPUUtilization (expected)", "id": "ad1", "color": "#95A5A6" } ]
                ],
                "region": "us-east-1"
            }
        },
        {
            "type": "metric",
            "x": 9,
            "y": 0,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/EC2", "EBSReadBytes", "InstanceId", "${module.computer.Instance_id}" ],
                    [ ".", "EBSWriteBytes", ".", "." ]
                ],
                "region": "us-east-1"
            }
        }
    ]
}
EOF
}


resource "aws_cloudwatch_metric_alarm" "cpu_util" {
  alarm_name                = "CPU-Util"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  threshold                 = "65"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

  dimensions = {
    InstanceId = module.computer.Instance_id
  }

  alarm_actions = ["arn:aws:sns:us-east-1:225908212644:MyTopic"]
}