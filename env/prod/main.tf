module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

  tags = {
    Environment = "prod"
    Project     = "terraform-app"
  }
}

module "alb" {
  source     = "../../modules/alb"
  name       = "app-alb-prod"
  subnet_ids = module.vpc.public_subnet_ids
  vpc_id     = module.vpc.vpc_id

  tags = {
    Environment = "prod"
    Project     = "terraform-app"
  }
}

module "asg" {
  source           = "../../modules/asg"
  name             = "app-prod"
  subnet_ids       = module.vpc.public_subnet_ids
  vpc_id           = module.vpc.vpc_id
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  desired_capacity = var.desired_capacity
  min_size         = 1
  max_size         = 2
  target_group_arn = module.alb.target_group_arn
  alb_sg_id        = module.alb.alb_sg_id

  tags = {
    Environment = "prod"
    Project     = "terraform-app"
  }
}