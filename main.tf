provider "aws" {
  region = "us-east-1" # Change to your preferred region
}

# Define regions (for future use)
variable "regions" {
  description = "List of AWS regions"
  type        = list(string)
  default     = ["us-east-1", "us-west-1"] # Add more regions later
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
  vpc_name            = "vpc-us-east-1"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones  = module.data_az.availability_zones # Pass AZs here
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