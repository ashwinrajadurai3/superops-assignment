#
resource "aws_lb" "web-server-lb" {
  name               = "web-server-lb"
  internal           = false
  load_balancer_type = "application"
  #security_groups    = [resource.ec2.aws_security_group.allow_http_ssh.id]
  security_groups    = [var.sg_id]
  #subnets            = [for subnet in aws_subnet.public_subnets : subnet.id]
  subnets            = var.public_subnet_id

  #   enable_deletion_protection = true

  # #   access_logs {
  # #     bucket  = aws_s3_bucket.lb_logs.id
  # #     prefix  = "test-lb"
  # #     enabled = true
  # #   }

  tags = {
    Environment = "production"
  }
}

#
resource "aws_lb_target_group_attachment" "lb_tg" {
  count            = 2
  target_group_arn = aws_lb_target_group.web-server-tg.arn
  #target_id        = element(aws_instance.web[*].id, count.index)
  target_id = element(var.instance_id,count.index)
  port = 80
}


#
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
  #vpc_id   = aws_vpc.main.id
  vpc_id   = var.vpc_id
}
