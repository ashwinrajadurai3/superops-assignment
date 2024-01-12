resource "aws_lb" "web-server-lb" {
  name               = "web-server-lb"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.security_group_id]
  subnets            = var.public_subnet_id
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.web-server-lb.arn
  port              = "80"
  protocol          = "HTTP"
  #   ssl_policy        = "ELBSecurityPolicy-2016-08"
  #   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-server-tg.arn
  }
}

resource "aws_lb_target_group" "web-server-tg" {
  name     = "web-server-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

