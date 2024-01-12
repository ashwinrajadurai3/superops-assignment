variable "security_group_id" { }

variable "public_subnet_id" {}

#variable "instance_id" { }

variable "vpc_id" { }

variable "load_balancer_type" {
    default = "application"
}

variable "internal" {
    default = false
}