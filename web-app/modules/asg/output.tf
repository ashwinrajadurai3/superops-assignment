output "aws_lt_id" {
  value = aws_launch_template.web-server-lt.id
}

output "subnet_id" {
  value = aws_launch_template.web-server-lt.network_interfaces[*].subnet_id
}

output "find_vpc_security_group_ids" {
    value = aws_launch_template.web-server-lt.vpc_security_group_ids
}
