resource "aws_launch_template" "web-server-lt" {
  name = "web-server-lt"

  image_id = "ami-0c7217cdde317cfec"

  instance_type = "t2.micro"

  key_name = var.aws_key

  network_interfaces {
    subnet_id = var.private_subnet_id[0]
    security_groups = [var.vpc_security_group_ids]
  }
  
  placement {
    availability_zone = "us-east-1a"
  }

  #vpc_security_group_ids = [var.vpc_security_group_ids]

  user_data = filebase64("${path.module}/user_data.sh")

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "web-server"
    }
  }
}


resource "aws_autoscaling_group" "web-server-asg" {
  #availability_zones = ["us-east-1a", "us-east-1b"]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 2
  vpc_zone_identifier       = var.private_subnet_id[*]

  launch_template {
    id      = aws_launch_template.web-server-lt.id
    version = "$Latest"
  }
}

# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = "${aws_autoscaling_group.web-server-asg.id}"
  lb_target_group_arn   = var.alb_target_group_arn
}