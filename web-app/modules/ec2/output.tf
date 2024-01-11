output "aws_security_group" {
  value = aws_security_group.allow_http_ssh.id
}

output "instance_id" {
    value = aws_instance.web[*].id
}

