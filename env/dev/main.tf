module "vpc" {
  source              = "../../modules/vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "alb" {
  source     = "../../modules/alb"
  name       = "app-alb-dev"
  subnet_ids = module.vpc.public_subnet_ids
  vpc_id     = module.vpc.vpc_id
}

module "asg" {
  source = "../../modules/asg"

  name       = "app-dev"
  subnet_ids = module.vpc.public_subnet_ids
  vpc_id     = module.vpc.vpc_id

  ami_id        = var.ami_id
  instance_type = var.instance_type

  min_size         = 1                 # ✅ FIX
  max_size         = 2                 # ✅ FIX
  desired_capacity = var.desired_capacity

  target_group_arn = module.alb.target_group_arn
  alb_sg_id        = module.alb.alb_sg_id

  tags = {                             # ✅ FIX
    Environment = "dev"
    Project     = "app"
  }
}

output "alb_dns" {
  value = module.alb.alb_dns
}