provider "aws" {
  region = var.regions[0] # us-east-1
}

# Fetch AZs for us-east-1
module "data_az" {
  source = "./modules/data_az"
  region = var.regions[0] # us-east-1
}

# Create a single VPC in us-east-1
module "vpc" {
  source = "./modules/vpc"

  region              = var.regions[0] # us-east-1
  vpc_cidr            = "10.0.0.0/16"
  vpc_name            = "${var.project_name}-vpc"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones  = module.data_az.availability_zones # Pass AZs here
}

module "sg" {
  source = "./modules/sg"

  vpc_id   = module.vpc.vpc_id
  name     = "${var.project_name}-sg"
  addrule  = ["ssh", "http"] # Add predefined rules here
  custom_rules = [
    {
      type        = "ingress"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  tags = {
    Project = var.project_name
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "security_group_id" {
  value = module.sg.security_group_id
}