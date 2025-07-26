module "vpc" {
  source = "../vpc"
  environment = var.environment
  vpc_cidr = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  azs = var.azs
}

module "ec2_1" {
    source = "../ec2"
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = module.vpc.public_subnet_ids[0]
    environment = var.environment
    name = "ec2-instance-1"
}

module "ec2_2" {
    source = "../ec2"
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = module.vpc.public_subnet_ids[1]
    environment = var.environment
    name = "ec2-instance-2"
}

module "ec2_3" {
    source = "../ec2"
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = module.vpc.public_subnet_ids[2]
    environment = var.environment
    name = "ec2-instance-3"
}