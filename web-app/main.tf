module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source            = "./modules/ec2"
  private_subnet_id = module.vpc.private_subnet_id
  vpc_id            = module.vpc.vpc_id
}

module "elb" {
  source            = "./modules/elb"
  public_subnet_id  = module.vpc.public_subnet_id
  security_group_id = module.ec2.aws_security_group
  #instance_id       = module.ec2.instance_id
  vpc_id = module.vpc.vpc_id
}

module "asg" {
  source                 = "./modules/asg"
  vpc_security_group_ids = module.ec2.aws_security_group
  aws_lb                 = module.elb.elb_id
  aws_key                = module.ec2.aws_key
  private_subnet_id      = module.vpc.private_subnet_id
  alb_target_group_arn   = module.elb.target_gp_arn
}