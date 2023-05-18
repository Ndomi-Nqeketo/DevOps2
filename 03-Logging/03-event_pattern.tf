resource "aws_cloudwatch_event_rule" "stopped_instance" {
  name        = "capture-stopped-instances"
  description = "Capture a stopped Instance"

  event_pattern = <<EOF
  {
      "source": [
          "aws.ec2"
      ],
      "detail-type": [
          "EC2 Instance State-change Notification"
      ],
      "detail": {
          "state": [
              "stopped"
          ]
      }
  }  
EOF
}

resource "aws_cloudwatch_event_target" "sns" {
  arn       = aws_sns_topic.ec2_stopped.arn
  rule      = aws_cloudwatch_event_rule.stopped_instance.name
  target_id = "SendToSNS"
}

resource "aws_sns_topic" "ec2_stopped" {
  name = "ec2-stopped"
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      identifiers = ["events.amazonaws.com"]
      type        = "Service"
    }
    resources = [aws_sns_topic.ec2_stopped.arn]
  }
}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.ec2_stopped.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}