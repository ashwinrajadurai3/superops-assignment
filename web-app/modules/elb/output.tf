output "Application_URL_is" {
  value = aws_lb.web-server-lb.dns_name
}

output "elb_id" {
  value = aws_lb.web-server-lb.id
}

output "target_gp_arn"{
  value = aws_lb_target_group.web-server-tg.arn
}

output "alb_arn" {
  value = aws_lb.web-server-lb.arn
}