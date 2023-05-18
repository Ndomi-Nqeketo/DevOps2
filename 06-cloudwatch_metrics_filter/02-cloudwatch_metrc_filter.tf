resource "aws_cloudwatch_log_group" "msg_loggroup" {
  name = "/var/log/messages"
}

resource "aws_cloudwatch_log_metric_filter" "messages" {
  name = "MyMessages"
  pattern = "root"
  log_group_name = aws_cloudwatch_log_group.msg_loggroup.name

  metric_transformation {
      name = "EventCount"
      namespace = "messages"
      value = "1"
  }  
}