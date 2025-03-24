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

# Create a security group
module "sg" {
  source = "./modules/sg"

  vpc_id   = module.vpc.vpc_id
  name     = "${var.project_name}-sg"
  addrule  = ["ssh", "http", "egress_all"] # Add predefined rules here
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

# Create IAM resources
module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
  tags         = var.tags
  users = [
    { name = "alice", group = "admins", existing = false },
    { name = "bob", group = "developers", existing = false }
  ]
}

# Create an EC2 instance in the first public subnet
module "ec2" {
  source = "./modules/ec2"

  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_id          = module.vpc.public_subnet_ids[0] # Use first public subnet
  security_group_id  = module.sg.security_group_id
  project_name       = var.project_name
  tags               = var.tags
  iam_instance_profile = module.iam.instance_profile_name
  user_data          = <<-EOF
                      #!/bin/bash
                      yum update -y
                      yum install -y httpd
                      systemctl start httpd
                      systemctl enable httpd
                      echo "<h1>Hello from Terraform EC2!</h1>" > /var/www/html/index.html
                      EOF
}