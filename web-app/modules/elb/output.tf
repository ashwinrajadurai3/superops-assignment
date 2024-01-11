output "Application_URL_is" {
  value = aws_lb.web-server-lb.dns_name
}