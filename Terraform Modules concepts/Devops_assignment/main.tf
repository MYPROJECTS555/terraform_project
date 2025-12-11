module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "nsg" {
  source = "./modules/nsg"
  vpc_id = module.vpc.vpc_id
  
}

module "ec2" {
  source = "./modules/ec2"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_id
  security_group_id = module.nsg.web_sg_id
  depends_on = [module.nsg]
}

module "elastic_ip" {
  source = "./modules/elastic_ip"
  instance_id = module.ec2.instance_id
  depends_on = [module.ec2]
}
