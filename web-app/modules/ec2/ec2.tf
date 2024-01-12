# Create key-pair
resource "aws_key_pair" "web-server" {
  key_name   = "web-server"
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "web-server" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "web-server"
}


# Create SG

resource "aws_security_group" "allow_http_ssh" {
  name        = "allow_http_ssh"
  description = "Allow http_ssh inbound traffic"

  vpc_id = var.vpc_id

  ingress {
    description = "Allow for http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow for ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    purpose = "web-server"
  }

}

# Create stack > EC2 with key-pair & SG 

# resource "aws_instance" "web" {
#   ami           = "ami-0c7217cdde317cfec"
#   instance_type = "t2.micro"
#   count         = 2

#   #subnet_id = var.private_subnet_id
#   subnet_id = element(var.private_subnet_id[*], count.index)
#   user_data = file("${path.module}/user_data.sh")

#   key_name               = aws_key_pair.web-server.id
#   vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]

#   tags = {
#     Name = "webserver-${count.index}"
#   }

# }