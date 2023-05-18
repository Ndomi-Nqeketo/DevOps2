output "alb_hostname" {
  value = aws_alb.ecs_alb.name
}

output "alb_name" {
  value = aws_alb.ecs_alb.dns_name
}