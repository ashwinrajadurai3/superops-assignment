provider "aws" {
  region  = "us-east-1"
  profile = "super-ops"
}

module "vpc" {
  source = "./modules/vpc"

}

module "ec2" {
  source            = "./modules/ec2"
  private_subnet_id = module.vpc.private_subnet_id
  vpc_id            = module.vpc.vpc_id

}

module "elb" {
  source           = "./modules/elb"
  public_subnet_id = module.vpc.public_subnet_id
  sg_id            = module.ec2.aws_security_group
  instance_id      = module.ec2.instance_id
  vpc_id           = module.vpc.vpc_id
}


output "Application_URL_is" {
  value = module.elb.Application_URL_is
}